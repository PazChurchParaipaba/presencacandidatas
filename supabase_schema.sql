-- Tabela para armazenar as meninas (candidatas)
CREATE TABLE public.candidates (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Tabela para os registros de presença de cada dia
CREATE TABLE public.attendances (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    date DATE NOT NULL,
    candidate_id UUID NOT NULL REFERENCES public.candidates(id) ON DELETE CASCADE,
    is_present BOOLEAN DEFAULT false NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    
    -- Garante que uma candidata não tenha duas presenças marcadas no mesmo dia
    UNIQUE(date, candidate_id)
);

-- Configurando RLS (Row Level Security) - Segurança básica do Supabase
ALTER TABLE public.candidates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendances ENABLE ROW LEVEL SECURITY;

-- Políticas de acesso público (Apenas para facilitar o desenvolvimento inicial)
-- IMPORTANTE: Em produção, você deve restringir isso para usuários autenticados!
CREATE POLICY "Permitir leitura pública de candidates" ON public.candidates FOR SELECT USING (true);
CREATE POLICY "Permitir inserção pública de candidates" ON public.candidates FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir atualização pública de candidates" ON public.candidates FOR UPDATE USING (true);
CREATE POLICY "Permitir deleção pública de candidates" ON public.candidates FOR DELETE USING (true);

CREATE POLICY "Permitir leitura pública de attendances" ON public.attendances FOR SELECT USING (true);
CREATE POLICY "Permitir inserção pública de attendances" ON public.attendances FOR INSERT WITH CHECK (true);
CREATE POLICY "Permitir atualização pública de attendances" ON public.attendances FOR UPDATE USING (true);
CREATE POLICY "Permitir deleção pública de attendances" ON public.attendances FOR DELETE USING (true);

-- Script Opcional: Inserir as meninas iniciais automaticamente no banco
INSERT INTO public.candidates (name) VALUES 
('Ana Patrícia'),
('Emilly Cristina'),
('Evelyn Ketlyn'),
('Hellen K'),
('Larissa Rodrigues'),
('Leticia Cipriano'),
('Luiza Chaves'),
('Mariana Gonçalves'),
('Mikaele Pinto'),
('Nathalia Costa'),
('Sangela Cordeiro'),
('Yasmin Farias');
