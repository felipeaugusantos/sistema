# Integração contínua — Plano de implementação da Fase 1

> **Para quem executa:** use a skill `superpowers:subagent-driven-development` (recomendado) ou `superpowers:executing-plans` para implementar tarefa a tarefa. Os passos usam checkbox (`- [ ]`) para acompanhamento.

**Objetivo:** compilar os 104 projetos distintos dos quatro groupprojs por linha de comando, com estado em disco, retomada, retry e log por projeto — sem depender da IDE.

**Arquitetura:** quatro módulos Python de responsabilidade única (`projetos`, `estado`, `compilador`, `ci`) mais um `.ini` de ajustes. O `ci.py` orquestra; os demais não conhecem a orquestração. Estado gravado após cada projeto, em JSON, um arquivo por execução.

**Tech stack:** Python 3 (somente biblioteca padrão — `configparser`, `xml.etree`, `json`, `subprocess`, `argparse`, `unittest`), MSBuild do RAD Studio 10.3.

**Spec:** [spec.md](spec.md) — ler antes de começar.

## Restrições globais

- **Zero dependências externas.** Só biblioteca padrão. O `_monitor` usa `pymysql`; a CI não precisa de banco e não deve adquirir dependência.
- **Python 3.14** é o interpretador da máquina (`C:\Program Files\Python314\python.exe`).
- **Encoding:** arquivos `.py` e `.md` em UTF-8. **Nunca** editar `.ini`, `.sql` ou `.pas` com acentos pela ferramenta Edit — ela troca bytes acentuados por U+FFFD em arquivos Windows-1252. Ver `IA/specs/459887/spec.md`.
- **Nomes sem acento** em código, config e mensagens de log, seguindo o que já existe em `_monitor` e nos runners.
- **Caminho base:** `padra_atualizado/Services/_ci/`.
- **Nada de paralelismo** (`msbuild /m`) nesta fase — ver "Fora de escopo" na spec.
- **`svn add`** em todo arquivo novo, sempre.
- **Tentativas por projeto:** 2.
- **MSBuild:** `C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe`; RAD Studio em `C:\Program Files (x86)\Embarcadero\Studio\20.0`.

## Estrutura de arquivos

| Arquivo | Responsabilidade |
|---|---|
| `_ci/projetos.py` | Ler os `.groupproj` e o `.ini`; devolver a lista ordenada, deduplicada e classificada |
| `_ci/estado.py` | Criar, gravar e ler a execução; decidir o que falta na retomada |
| `_ci/compilador.py` | Montar o ambiente do Delphi, invocar o MSBuild, aplicar retry, devolver resultado |
| `_ci/ci.py` | CLI e orquestração; a política de base/folha vive aqui |
| `_ci/ci.ini` | Grupos, modo por projeto, quais são base, exclusões |
| `_ci/testes/test_*.py` | `unittest` por módulo |
| `_ci/LEIAME.txt` | Como usar, e as armadilhas conhecidas |

---

### Task 1: Ler os groupprojs e deduplicar

**Files:**
- Create: `padra_atualizado/Services/_ci/projetos.py`
- Create: `padra_atualizado/Services/_ci/testes/test_projetos.py`
- Create: `padra_atualizado/Services/_ci/testes/dados/exemplo.groupproj`

**Interfaces:**
- Produz: `ler_groupproj(caminho: str) -> list[str]` — caminhos relativos dos `.dproj`, na ordem declarada
- Produz: `deduplicar(itens: list[str]) -> list[str]` — mantém a primeira ocorrência

- [ ] **Step 1: Criar o groupproj de exemplo para o teste**

`testes/dados/exemplo.groupproj` — reproduz o namespace real do MSBuild, que é o detalhe que quebra parsers ingênuos:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    <ItemGroup>
        <Projects Include="..\Packages\Shared\Functions\package\Linux\Shared.Functions.dproj">
            <Dependencies/>
        </Projects>
        <Projects Include="Lib\autcomtinta\Linux\AutcomTinta.dproj">
            <Dependencies/>
        </Projects>
        <Projects Include="Lib\LibTintas\libTintaAdvance\TintaAdvance.dproj">
            <Dependencies/>
        </Projects>
    </ItemGroup>
</Project>
```

- [ ] **Step 2: Escrever o teste que falha**

`testes/test_projetos.py`:

```python
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import projetos

AQUI = os.path.dirname(os.path.abspath(__file__))
EXEMPLO = os.path.join(AQUI, "dados", "exemplo.groupproj")


class TestLerGroupproj(unittest.TestCase):
    def test_devolve_projetos_na_ordem_declarada(self):
        # A ordem importa: Shared.Functions precisa vir antes do AutcomTinta,
        # que precisa vir antes das marcas.
        lidos = projetos.ler_groupproj(EXEMPLO)
        self.assertEqual(
            lidos,
            [
                r"..\Packages\Shared\Functions\package\Linux\Shared.Functions.dproj",
                r"Lib\autcomtinta\Linux\AutcomTinta.dproj",
                r"Lib\LibTintas\libTintaAdvance\TintaAdvance.dproj",
            ],
        )

    def test_ignora_namespace_do_msbuild(self):
        # O groupproj real declara xmlns; um find() sem namespace devolve vazio.
        self.assertEqual(len(projetos.ler_groupproj(EXEMPLO)), 3)


class TestDeduplicar(unittest.TestCase):
    def test_mantem_primeira_ocorrencia(self):
        # Shared.Functions esta nos quatro groupprojs e hoje compila 4x por ciclo.
        entrada = ["Shared.Functions.dproj", "NFe.dproj", "Shared.Functions.dproj"]
        self.assertEqual(
            projetos.deduplicar(entrada), ["Shared.Functions.dproj", "NFe.dproj"]
        )

    def test_lista_vazia(self):
        self.assertEqual(projetos.deduplicar([]), [])


if __name__ == "__main__":
    unittest.main()
```

- [ ] **Step 3: Rodar e confirmar que falha**

```
python padra_atualizado\Services\_ci\testes\test_projetos.py
```

Esperado: `ModuleNotFoundError: No module named 'projetos'`

- [ ] **Step 4: Implementar o mínimo**

`projetos.py`:

```python
# -*- coding: utf-8 -*-
"""Monta a lista de projetos da CI a partir dos .groupproj e do ci.ini."""

import xml.etree.ElementTree as ET


def ler_groupproj(caminho):
    """Caminhos dos .dproj na ordem em que o groupproj os declara.

    O groupproj usa o namespace do MSBuild, entao a busca precisa do {*} -
    procurar por 'Projects' direto devolve lista vazia sem avisar.
    """
    raiz = ET.parse(caminho).getroot()
    return [
        no.get("Include")
        for no in raiz.iter("{*}Projects")
        if no.get("Include")
    ]


def deduplicar(itens):
    """Primeira ocorrencia vence - a ordem inicial e a que respeita dependencia.

    Shared.Functions aparece nos quatro groupprojs e NFe em dois; sem isto,
    ambos recompilam do zero a cada grupo.
    """
    vistos = set()
    saida = []
    for item in itens:
        chave = item.lower()
        if chave not in vistos:
            vistos.add(chave)
            saida.append(item)
    return saida
```

- [ ] **Step 5: Rodar e confirmar que passa**

```
python padra_atualizado\Services\_ci\testes\test_projetos.py
```

Esperado: `OK` (4 testes)

- [ ] **Step 6: Validar contra os groupprojs reais**

```
python -c "import sys; sys.path.insert(0, r'padra_atualizado\Services\_ci'); import projetos; print(len(projetos.ler_groupproj(r'padra_atualizado\Services\Services.Tintas.groupproj')))"
```

Esperado: `91`

- [ ] **Step 7: Commit**

```
svn add padra_atualizado\Services\_ci --parents
svn commit -m "Req. ####  CI: leitura dos groupprojs e deduplicacao"
```

---

### Task 2: Configuração e classificação dos projetos

**Files:**
- Create: `padra_atualizado/Services/_ci/ci.ini`
- Modify: `padra_atualizado/Services/_ci/projetos.py`
- Modify: `padra_atualizado/Services/_ci/testes/test_projetos.py`

**Interfaces:**
- Consome: `ler_groupproj`, `deduplicar` (Task 1)
- Produz: `Projeto` — namedtuple com campos `caminho`, `nome`, `grupo`, `modo`, `base`
- Produz: `montar_lista(dir_services: str, caminho_ini: str) -> list[Projeto]`

- [ ] **Step 1: Criar o ci.ini**

Sem acentos, para não depender de encoding. `allow_no_value=True` permite listar nomes sem `=`.

```ini
; Ajustes da CI. O que existe e em que ordem vem dos .groupproj;
; aqui fica apenas COMO compilar.

[geral]
modo_padrao = make
tentativas = 2

[grupos]
; Ordem em que os grupos sao processados. Nome = arquivo .groupproj.
tintas     = Services.Tintas.groupproj
faturamento = Services.Faturamento.Tests.groupproj
financeiro = Services.Financeiro.Tests.groupproj
suprimento = Services.Suprimento.Tests.groupproj

[build]
; Projetos que exigem build completo em vez de make.
; AutcomTinta: sofre a falha intermitente de link (ver spec, anexo).
AutcomTinta

[base]
; Falha nestes interrompe o grupo - seguir so produziria erro em cascata.
Shared.Functions
NFe
api.rest
AutcomTinta
FaturamentoServicesAPI
FinanceiroServicesAPI
SuprimentoServicesAPI

[pular]
; Exclusoes temporarias. Sempre com o motivo em comentario e o requisito.
```

- [ ] **Step 2: Escrever o teste que falha**

Acrescentar a `testes/test_projetos.py`:

```python
import tempfile


class TestMontarLista(unittest.TestCase):
    def setUp(self):
        self.dir = tempfile.mkdtemp()
        with open(os.path.join(self.dir, "G1.groupproj"), "w", encoding="utf-8") as fh:
            fh.write(
                '<?xml version="1.0" encoding="utf-8"?>'
                '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">'
                "<ItemGroup>"
                '<Projects Include="a\\Shared.Functions.dproj"/>'
                '<Projects Include="b\\AutcomTinta.dproj"/>'
                '<Projects Include="c\\TintaAdvance.dproj"/>'
                '<Projects Include="d\\TintaObsoleta.dproj"/>'
                "</ItemGroup></Project>"
            )
        with open(os.path.join(self.dir, "G2.groupproj"), "w", encoding="utf-8") as fh:
            fh.write(
                '<?xml version="1.0" encoding="utf-8"?>'
                '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">'
                "<ItemGroup>"
                '<Projects Include="a\\Shared.Functions.dproj"/>'
                '<Projects Include="e\\FaturamentoServicesAPI.dproj"/>'
                "</ItemGroup></Project>"
            )
        self.ini = os.path.join(self.dir, "ci.ini")
        with open(self.ini, "w", encoding="utf-8") as fh:
            fh.write(
                "[geral]\nmodo_padrao = make\ntentativas = 2\n"
                "[grupos]\ng1 = G1.groupproj\ng2 = G2.groupproj\n"
                "[build]\nAutcomTinta\n"
                "[base]\nShared.Functions\nAutcomTinta\nFaturamentoServicesAPI\n"
                "[pular]\nTintaObsoleta\n"
            )

    def test_ordem_dos_grupos_e_do_conteudo(self):
        lista = projetos.montar_lista(self.dir, self.ini)
        self.assertEqual(
            [p.nome for p in lista],
            ["Shared.Functions", "AutcomTinta", "TintaAdvance", "FaturamentoServicesAPI"],
        )

    def test_shared_functions_aparece_uma_vez_so(self):
        lista = projetos.montar_lista(self.dir, self.ini)
        self.assertEqual([p.nome for p in lista].count("Shared.Functions"), 1)

    def test_grupo_da_primeira_ocorrencia(self):
        lista = projetos.montar_lista(self.dir, self.ini)
        self.assertEqual(lista[0].grupo, "g1")

    def test_modo_build_apenas_no_listado(self):
        modos = {p.nome: p.modo for p in projetos.montar_lista(self.dir, self.ini)}
        self.assertEqual(modos["AutcomTinta"], "build")
        self.assertEqual(modos["TintaAdvance"], "make")

    def test_base_marcado(self):
        base = {p.nome: p.base for p in projetos.montar_lista(self.dir, self.ini)}
        self.assertTrue(base["Shared.Functions"])
        self.assertFalse(base["TintaAdvance"])

    def test_pular_remove_da_lista(self):
        nomes = [p.nome for p in projetos.montar_lista(self.dir, self.ini)]
        self.assertNotIn("TintaObsoleta", nomes)
```

- [ ] **Step 3: Rodar e confirmar que falha**

```
python padra_atualizado\Services\_ci\testes\test_projetos.py
```

Esperado: `AttributeError: module 'projetos' has no attribute 'montar_lista'`

- [ ] **Step 4: Implementar**

Acrescentar a `projetos.py`:

```python
import collections
import configparser
import os

Projeto = collections.namedtuple("Projeto", "caminho nome grupo modo base")


def ler_ini(caminho):
    """Publica de proposito: o ci.py le 'tentativas' daqui."""
    cfg = configparser.ConfigParser(allow_no_value=True)
    cfg.optionxform = str  # preserva a caixa dos nomes de projeto
    cfg.read(caminho, encoding="latin-1")
    return cfg


def _nome(caminho_dproj):
    return os.path.splitext(os.path.basename(caminho_dproj))[0]


def montar_lista(dir_services, caminho_ini):
    """Lista ordenada, deduplicada e classificada dos projetos da CI.

    Ordem: a dos grupos no .ini, e dentro de cada grupo a do .groupproj.
    Um projeto em dois grupos fica no primeiro - e onde ele precisa existir
    para os seguintes.
    """
    cfg = ler_ini(caminho_ini)
    modo_padrao = cfg.get("geral", "modo_padrao", fallback="make")
    com_build = set(cfg.options("build")) if cfg.has_section("build") else set()
    sao_base = set(cfg.options("base")) if cfg.has_section("base") else set()
    pular = set(cfg.options("pular")) if cfg.has_section("pular") else set()

    lista = []
    vistos = set()
    for grupo, arquivo in cfg.items("grupos"):
        caminho_gp = os.path.join(dir_services, arquivo)
        for rel in ler_groupproj(caminho_gp):
            nome = _nome(rel)
            if nome in pular or nome.lower() in vistos:
                continue
            vistos.add(nome.lower())
            lista.append(
                Projeto(
                    caminho=rel,
                    nome=nome,
                    grupo=grupo,
                    modo="build" if nome in com_build else modo_padrao,
                    base=nome in sao_base,
                )
            )
    return lista
```

- [ ] **Step 5: Rodar e confirmar que passa**

```
python padra_atualizado\Services\_ci\testes\test_projetos.py
```

Esperado: `OK` (10 testes)

- [ ] **Step 6: Conferir o número real de projetos distintos**

```
python -c "import sys,os; d=r'padra_atualizado\Services'; sys.path.insert(0, os.path.join(d,'_ci')); import projetos; l=projetos.montar_lista(d, os.path.join(d,'_ci','ci.ini')); print(len(l), 'distintos'); print(sum(1 for p in l if p.base), 'base')"
```

Esperado: `104 distintos` e `7 base`. Se der 108, a deduplicação não pegou — investigar antes de seguir.

- [ ] **Step 7: Commit**

```
svn add padra_atualizado\Services\_ci\ci.ini
svn commit -m "Req. ####  CI: configuracao e classificacao base/folha"
```

---

### Task 3: Estado da execução e retomada

**Files:**
- Create: `padra_atualizado/Services/_ci/estado.py`
- Create: `padra_atualizado/Services/_ci/testes/test_estado.py`

**Interfaces:**
- Consome: `Projeto` (Task 2)
- Produz: `criar(revisao, gatilho, lista_projetos) -> dict`
- Produz: `gravar(dir_exec, execucao, ponteiro=True) -> None` — com `ponteiro=False` grava o arquivo mas **não** mexe no `atual.json`, para que uma compilação avulsa (`--projeto`, `--grupo`, `--desde`) não sequestre a execução em andamento (critério 7 da spec)
- Produz: `carregar_atual(dir_exec) -> dict | None`
- Produz: `marcar(execucao, nome, status, **extras) -> None`
- Produz: `pendentes(execucao) -> list[dict]` — o que a retomada precisa fazer

- [ ] **Step 1: Escrever o teste que falha**

```python
# -*- coding: utf-8 -*-
import json
import os
import shutil
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import estado
import projetos


def _projetos():
    return [
        projetos.Projeto("a\\Shared.Functions.dproj", "Shared.Functions", "g1", "make", True),
        projetos.Projeto("b\\AutcomTinta.dproj", "AutcomTinta", "g1", "build", True),
        projetos.Projeto("c\\TintaAdvance.dproj", "TintaAdvance", "g1", "make", False),
    ]


class TestEstado(unittest.TestCase):
    def setUp(self):
        self.dir = tempfile.mkdtemp()

    def tearDown(self):
        shutil.rmtree(self.dir, ignore_errors=True)

    def test_criar_deixa_tudo_pendente(self):
        ex = estado.criar(491549, "ciclo", _projetos())
        self.assertEqual(ex["revisao"], 491549)
        self.assertEqual(ex["situacao"], "em_andamento")
        self.assertTrue(all(p["status"] == "pendente" for p in ex["projetos"]))

    def test_gravar_e_carregar_pelo_atual(self):
        ex = estado.criar(491549, "ciclo", _projetos())
        estado.gravar(self.dir, ex)
        lido = estado.carregar_atual(self.dir)
        self.assertEqual(lido["revisao"], 491549)

    def test_carregar_sem_execucao_devolve_none(self):
        self.assertIsNone(estado.carregar_atual(self.dir))

    def test_gravar_sem_ponteiro_nao_sequestra_a_execucao_corrente(self):
        # Criterio 7 da spec: --projeto/--grupo nao podem atropelar o --ciclo parado.
        ciclo = estado.criar(100, "ciclo", _projetos())
        estado.gravar(self.dir, ciclo)
        avulsa = estado.criar(200, "projeto", _projetos())
        estado.gravar(self.dir, avulsa, ponteiro=False)
        self.assertEqual(estado.carregar_atual(self.dir)["revisao"], 100)

    def test_marcar_altera_so_o_alvo(self):
        ex = estado.criar(1, "ciclo", _projetos())
        estado.marcar(ex, "AutcomTinta", "ok", segundos=212, tentativas=2)
        alvo = [p for p in ex["projetos"] if p["nome"] == "AutcomTinta"][0]
        self.assertEqual(alvo["status"], "ok")
        self.assertEqual(alvo["segundos"], 212)
        outro = [p for p in ex["projetos"] if p["nome"] == "TintaAdvance"][0]
        self.assertEqual(outro["status"], "pendente")

    def test_pendentes_exclui_ok_e_pulado(self):
        ex = estado.criar(1, "ciclo", _projetos())
        estado.marcar(ex, "Shared.Functions", "ok")
        estado.marcar(ex, "AutcomTinta", "falhou")
        nomes = [p["nome"] for p in estado.pendentes(ex)]
        # falhou entra: a retomada tenta de novo. ok nao entra.
        self.assertEqual(nomes, ["AutcomTinta", "TintaAdvance"])

    def test_gravacao_sobrevive_a_processo_morto(self):
        # Grava a cada projeto; ler o arquivo cru tem de refletir o ultimo marcado.
        ex = estado.criar(1, "ciclo", _projetos())
        estado.marcar(ex, "Shared.Functions", "ok")
        estado.gravar(self.dir, ex)
        with open(os.path.join(self.dir, "atual.json"), encoding="utf-8") as fh:
            ponteiro = json.load(fh)
        with open(os.path.join(self.dir, ponteiro["arquivo"]), encoding="utf-8") as fh:
            disco = json.load(fh)
        alvo = [p for p in disco["projetos"] if p["nome"] == "Shared.Functions"][0]
        self.assertEqual(alvo["status"], "ok")


if __name__ == "__main__":
    unittest.main()
```

- [ ] **Step 2: Rodar e confirmar que falha**

```
python padra_atualizado\Services\_ci\testes\test_estado.py
```

Esperado: `ModuleNotFoundError: No module named 'estado'`

- [ ] **Step 3: Implementar**

```python
# -*- coding: utf-8 -*-
"""Estado de uma execucao da CI: um arquivo por execucao, mais um ponteiro.

Gravado APOS CADA PROJETO. Morrer no projeto 47 nao pode custar os 46 anteriores.
"""

import json
import os

ARQ_PONTEIRO = "atual.json"

# 'falhou' e 'bloqueado' voltam para a fila: a retomada tenta de novo.
# 'pulado' foi excluido no .ini de proposito; 'ok' ja esta feito.
REFAZER = ("pendente", "falhou", "bloqueado")


def criar(revisao, gatilho, lista_projetos):
    return {
        "revisao": revisao,
        "gatilho": gatilho,
        "situacao": "em_andamento",
        "projetos": [
            {
                "nome": p.nome,
                "caminho": p.caminho,
                "grupo": p.grupo,
                "modo": p.modo,
                "base": p.base,
                "status": "pendente",
            }
            for p in lista_projetos
        ],
    }


def nome_arquivo(execucao):
    # O gatilho entra no nome para que um --projeto na mesma revisao nao
    # sobrescreva o arquivo do --ciclo.
    return "r%s_%s.json" % (execucao["revisao"], execucao["gatilho"])


def gravar(dir_exec, execucao, ponteiro=True):
    """Grava a execucao. Com ponteiro=False nao mexe no atual.json.

    Compilacao avulsa (--projeto, --grupo, --desde) grava seu proprio arquivo
    mas nao pode sequestrar o ponteiro: o --ciclo que ficou parado no meio
    precisa continuar sendo o que o --retomar encontra.
    """
    os.makedirs(dir_exec, exist_ok=True)
    arquivo = nome_arquivo(execucao)
    caminho = os.path.join(dir_exec, arquivo)

    # Grava em temporario e substitui: se o processo morrer no meio da escrita,
    # o arquivo bom continua no lugar em vez de virar JSON truncado.
    tmp = caminho + ".tmp"
    with open(tmp, "w", encoding="utf-8") as fh:
        json.dump(execucao, fh, ensure_ascii=False, indent=2)
    os.replace(tmp, caminho)

    if ponteiro:
        with open(os.path.join(dir_exec, ARQ_PONTEIRO), "w", encoding="utf-8") as fh:
            json.dump({"arquivo": arquivo}, fh)


def carregar_atual(dir_exec):
    ponteiro = os.path.join(dir_exec, ARQ_PONTEIRO)
    if not os.path.isfile(ponteiro):
        return None
    with open(ponteiro, encoding="utf-8") as fh:
        arquivo = json.load(fh).get("arquivo")
    caminho = os.path.join(dir_exec, arquivo or "")
    if not arquivo or not os.path.isfile(caminho):
        return None
    with open(caminho, encoding="utf-8") as fh:
        return json.load(fh)


def marcar(execucao, nome, status, **extras):
    for p in execucao["projetos"]:
        if p["nome"] == nome:
            p["status"] = status
            p.update(extras)
            return
    raise KeyError("projeto fora da execucao: %s" % nome)


def pendentes(execucao):
    return [p for p in execucao["projetos"] if p["status"] in REFAZER]
```

- [ ] **Step 4: Rodar e confirmar que passa**

```
python padra_atualizado\Services\_ci\testes\test_estado.py
```

Esperado: `OK` (6 testes)

- [ ] **Step 5: Commit**

```
svn add padra_atualizado\Services\_ci\estado.py padra_atualizado\Services\_ci\testes\test_estado.py
svn commit -m "Req. ####  CI: estado da execucao e retomada"
```

---

### Task 4: Invocar o MSBuild com retry

**Files:**
- Create: `padra_atualizado/Services/_ci/compilador.py`
- Create: `padra_atualizado/Services/_ci/testes/test_compilador.py`

**Interfaces:**
- Produz: `ambiente_delphi(dir_bds: str) -> dict` — cópia de `os.environ` com BDS e PATH ajustados
- Produz: `montar_comando(dproj, modo, log, dir_bds) -> list[str]`
- Produz: `Resultado` — namedtuple `ok`, `tentativas`, `segundos`, `erro`, `nota`
- Produz: `compilar(dproj, modo, log, dir_bds, tentativas=2, executor=None) -> Resultado`

O parâmetro `executor` existe para o teste: injeta uma função no lugar do `subprocess`, tornando o retry testável sem compilar nada.

- [ ] **Step 1: Escrever o teste que falha**

```python
# -*- coding: utf-8 -*-
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import compilador

BDS = r"C:\Program Files (x86)\Embarcadero\Studio\20.0"


class TestComando(unittest.TestCase):
    def test_modo_build_usa_target_Build(self):
        cmd = compilador.montar_comando(r"x\A.dproj", "build", r"logs\A.log", BDS)
        self.assertIn("/t:Build", cmd)
        self.assertNotIn("/t:Make", cmd)

    def test_modo_make_usa_target_Make(self):
        cmd = compilador.montar_comando(r"x\A.dproj", "make", r"logs\A.log", BDS)
        self.assertIn("/t:Make", cmd)

    def test_sempre_linux64_release(self):
        cmd = compilador.montar_comando(r"x\A.dproj", "make", r"logs\A.log", BDS)
        self.assertIn("/p:Platform=Linux64", cmd)
        self.assertIn("/p:Config=Release", cmd)

    def test_log_por_projeto(self):
        cmd = compilador.montar_comando(r"x\A.dproj", "make", r"logs\A.log", BDS)
        self.assertTrue(any("logs\\A.log" in p for p in cmd))


class TestAmbiente(unittest.TestCase):
    def test_define_bds_e_poe_bin_no_path(self):
        env = compilador.ambiente_delphi(BDS)
        self.assertEqual(env["BDS"], BDS)
        self.assertIn(os.path.join(BDS, "bin"), env["PATH"])


class TestRetry(unittest.TestCase):
    def test_sucesso_na_primeira_nao_repete(self):
        chamadas = []

        def executor(cmd, env):
            chamadas.append(cmd)
            return 0, ""

        r = compilador.compilar(r"x\A.dproj", "make", "A.log", BDS, executor=executor)
        self.assertTrue(r.ok)
        self.assertEqual(r.tentativas, 1)
        self.assertEqual(len(chamadas), 1)

    def test_falha_na_primeira_e_sucesso_na_segunda_registra_nota(self):
        # Caso real do AutcomTinta: E2597 na primeira, passa na segunda.
        estados = [(1, "E2597 ld-linux.exe: fatal error: no input files"), (0, "")]

        def executor(cmd, env):
            return estados.pop(0)

        r = compilador.compilar(r"x\A.dproj", "build", "A.log", BDS, executor=executor)
        self.assertTrue(r.ok)
        self.assertEqual(r.tentativas, 2)
        self.assertIn("E2597", r.nota)

    def test_esgota_tentativas_e_devolve_erro(self):
        def executor(cmd, env):
            return 1, "E2597 no input files"

        r = compilador.compilar(
            r"x\A.dproj", "build", "A.log", BDS, tentativas=2, executor=executor
        )
        self.assertFalse(r.ok)
        self.assertEqual(r.tentativas, 2)
        self.assertIn("E2597", r.erro)


if __name__ == "__main__":
    unittest.main()
```

- [ ] **Step 2: Rodar e confirmar que falha**

```
python padra_atualizado\Services\_ci\testes\test_compilador.py
```

Esperado: `ModuleNotFoundError: No module named 'compilador'`

- [ ] **Step 3: Implementar**

```python
# -*- coding: utf-8 -*-
"""Invoca o MSBuild para um projeto Delphi, com retry.

Usa MSBuild e nao bds.exe: exit code confiavel, log por projeto e nenhuma
dependencia de IDE aberta ou sessao grafica.
"""

import collections
import os
import subprocess
import time

MSBUILD = r"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"

Resultado = collections.namedtuple("Resultado", "ok tentativas segundos erro nota")


def ambiente_delphi(dir_bds):
    """Replica o que o rsvars.bat faz, sem depender de shell."""
    env = dict(os.environ)
    env["BDS"] = dir_bds
    env["BDSINCLUDE"] = os.path.join(dir_bds, "include")
    env["BDSCOMMONDIR"] = r"C:\Users\Public\Documents\Embarcadero\Studio\20.0"
    env["FrameworkDir"] = r"C:\Windows\Microsoft.NET\Framework\v4.0.30319"
    env["FrameworkVersion"] = "v4.5"
    env["PATH"] = os.pathsep.join(
        [
            env["FrameworkDir"],
            os.path.join(dir_bds, "bin"),
            os.path.join(dir_bds, "bin64"),
            env.get("PATH", ""),
        ]
    )
    return env


def montar_comando(dproj, modo, log, dir_bds):
    alvo = "/t:Build" if modo == "build" else "/t:Make"
    return [
        MSBUILD,
        dproj,
        alvo,
        "/p:Config=Release",
        "/p:Platform=Linux64",
        "/nologo",
        "/v:minimal",
        "/flp:LogFile=%s;Verbosity=normal" % log,
    ]


def _executor_real(cmd, env):
    proc = subprocess.run(
        cmd, env=env, capture_output=True, text=True, errors="replace"
    )
    return proc.returncode, (proc.stdout or "") + (proc.stderr or "")


def _resumo_do_erro(saida):
    for linha in (saida or "").splitlines():
        if "error " in linha.lower() or "E2597" in linha or "F2588" in linha:
            return linha.strip()[:200]
    return (saida or "").strip()[-200:]


def compilar(dproj, modo, log, dir_bds, tentativas=2, executor=None, saida_so=None):
    """Compila com ate N tentativas. Devolve Resultado.

    Entre tentativas apaga o .so de saida, se informado: artefato meio escrito
    de uma tentativa abortada pode confundir a seguinte.

    Quando falha na primeira e passa na segunda, isso vai em 'nota'. Falha
    intermitente que se cura sozinha some do radar se ninguem anotar.
    """
    executor = executor or _executor_real
    env = ambiente_delphi(dir_bds)
    cmd = montar_comando(dproj, modo, log, dir_bds)

    inicio = time.monotonic()
    nota = ""
    erro = ""
    for tentativa in range(1, tentativas + 1):
        if tentativa > 1 and saida_so and os.path.isfile(saida_so):
            try:
                os.remove(saida_so)
            except OSError:
                pass

        codigo, saida = executor(cmd, env)
        if codigo == 0:
            return Resultado(
                ok=True,
                tentativas=tentativa,
                segundos=round(time.monotonic() - inicio),
                erro="",
                nota=nota,
            )

        erro = _resumo_do_erro(saida)
        if tentativa == 1:
            nota = "1a tentativa: %s" % erro

    return Resultado(
        ok=False,
        tentativas=tentativas,
        segundos=round(time.monotonic() - inicio),
        erro=erro,
        nota=nota,
    )
```

- [ ] **Step 4: Rodar e confirmar que passa**

```
python padra_atualizado\Services\_ci\testes\test_compilador.py
```

Esperado: `OK` (8 testes)

- [ ] **Step 5: Provar contra um projeto real**

Compilar de verdade o projeto mais barato do conjunto:

```
python -c "import sys; sys.path.insert(0, r'padra_atualizado\Services\_ci'); import compilador; r = compilador.compilar(r'padra_atualizado\Services\Suprimento.Services.API\Target\Linux\SuprimentoServicesAPI.dproj', 'make', r'c:\tmp\sup.log', r'C:\Program Files (x86)\Embarcadero\Studio\20.0'); print(r)"
```

Esperado: `ok=True`. Se vier `ok=False`, ler `c:\tmp\sup.log` antes de seguir — pode ser caminho relativo, e o MSBuild precisa do `.dproj` acessível a partir do diretório corrente.

- [ ] **Step 6: Commit**

```
svn add padra_atualizado\Services\_ci\compilador.py padra_atualizado\Services\_ci\testes\test_compilador.py
svn commit -m "Req. ####  CI: invocacao do msbuild com retry"
```

---

### Task 5: CLI e orquestração

**Files:**
- Create: `padra_atualizado/Services/_ci/ci.py`
- Create: `padra_atualizado/Services/_ci/testes/test_ci.py`

**Interfaces:**
- Consome: `projetos.montar_lista`, `estado.*`, `compilador.compilar`
- Produz: `revisao_svn(dir_wc: str) -> int`
- Produz: `filtrar(lista, grupo=None, projeto=None, desde=None) -> list[Projeto]`
- Produz: `executar(lista, execucao, dir_exec, dir_bds, dir_logs, tentativas, compilar_fn=None, ponteiro=True) -> dict`

A política base/folha vive no `executar`: falha em `base` bloqueia o resto **daquele grupo**; falha em folha não bloqueia ninguém.

- [ ] **Step 1: Escrever o teste que falha**

```python
# -*- coding: utf-8 -*-
import os
import shutil
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import compilador
import ci
import estado
import projetos


def _lista():
    return [
        projetos.Projeto("a\\Shared.Functions.dproj", "Shared.Functions", "g1", "make", True),
        projetos.Projeto("b\\AutcomTinta.dproj", "AutcomTinta", "g1", "build", True),
        projetos.Projeto("c\\TintaAdvance.dproj", "TintaAdvance", "g1", "make", False),
        projetos.Projeto("d\\TintaBeta.dproj", "TintaBeta", "g1", "make", False),
        projetos.Projeto("e\\SuprimentoServicesAPI.dproj", "SuprimentoServicesAPI", "g2", "make", True),
    ]


def _ok(*a, **k):
    return compilador.Resultado(True, 1, 1, "", "")


def _falha(*a, **k):
    return compilador.Resultado(False, 2, 1, "E2597 no input files", "")


class TestFiltrar(unittest.TestCase):
    def test_por_grupo(self):
        r = ci.filtrar(_lista(), grupo="g2")
        self.assertEqual([p.nome for p in r], ["SuprimentoServicesAPI"])

    def test_por_projeto(self):
        r = ci.filtrar(_lista(), projeto="AutcomTinta")
        self.assertEqual([p.nome for p in r], ["AutcomTinta"])

    def test_desde_inclui_o_alvo_e_o_que_vem_depois(self):
        r = ci.filtrar(_lista(), desde="TintaAdvance")
        self.assertEqual(
            [p.nome for p in r],
            ["TintaAdvance", "TintaBeta", "SuprimentoServicesAPI"],
        )

    def test_sem_filtro_devolve_tudo(self):
        self.assertEqual(len(ci.filtrar(_lista())), 5)


class TestExecutar(unittest.TestCase):
    def setUp(self):
        self.dir = tempfile.mkdtemp()

    def tearDown(self):
        shutil.rmtree(self.dir, ignore_errors=True)

    def _rodar(self, compilar_fn):
        lista = _lista()
        ex = estado.criar(1, "ciclo", lista)
        return ci.executar(
            lista, ex, self.dir, "BDS", self.dir, 2, compilar_fn=compilar_fn
        )

    def test_tudo_ok_conclui(self):
        ex = self._rodar(_ok)
        self.assertEqual(ex["situacao"], "concluida")
        self.assertTrue(all(p["status"] == "ok" for p in ex["projetos"]))

    def test_falha_em_base_bloqueia_o_resto_do_grupo_mas_nao_o_outro(self):
        def fn(dproj, modo, log, dir_bds, tentativas, saida_so=None):
            return _falha() if "AutcomTinta" in dproj else _ok()

        ex = self._rodar(fn)
        por_nome = {p["nome"]: p["status"] for p in ex["projetos"]}
        self.assertEqual(por_nome["Shared.Functions"], "ok")
        self.assertEqual(por_nome["AutcomTinta"], "falhou")
        self.assertEqual(por_nome["TintaAdvance"], "bloqueado")
        self.assertEqual(por_nome["TintaBeta"], "bloqueado")
        # grupo diferente segue normalmente
        self.assertEqual(por_nome["SuprimentoServicesAPI"], "ok")

    def test_falha_em_folha_nao_bloqueia_ninguem(self):
        def fn(dproj, modo, log, dir_bds, tentativas, saida_so=None):
            return _falha() if "TintaAdvance" in dproj else _ok()

        ex = self._rodar(fn)
        por_nome = {p["nome"]: p["status"] for p in ex["projetos"]}
        self.assertEqual(por_nome["TintaAdvance"], "falhou")
        self.assertEqual(por_nome["TintaBeta"], "ok")
        self.assertEqual(ex["situacao"], "concluida_com_falhas")

    def test_grava_a_cada_projeto(self):
        self._rodar(_ok)
        disco = estado.carregar_atual(self.dir)
        self.assertEqual(len(disco["projetos"]), 5)


if __name__ == "__main__":
    unittest.main()
```

- [ ] **Step 2: Rodar e confirmar que falha**

```
python padra_atualizado\Services\_ci\testes\test_ci.py
```

Esperado: `ModuleNotFoundError: No module named 'ci'`

- [ ] **Step 3: Implementar**

```python
# -*- coding: utf-8 -*-
"""Integracao continua - compilacao dos projetos Linux. Fase 1.

  ci.py --ciclo                  compila tudo, na ordem, deduplicado
  ci.py --retomar                continua a execucao parada, na revisao dela
  ci.py --grupo tintas           so um grupo
  ci.py --projeto AutcomTinta    so um, para investigar
  ci.py --desde TintaGeneral     do projeto X em diante

Ver LEIAME.txt para as armadilhas conhecidas.
"""

import argparse
import os
import re
import subprocess
import sys

import compilador
import estado
import projetos

AQUI = os.path.dirname(os.path.abspath(__file__))
DIR_SERVICES = os.path.dirname(AQUI)
DIR_EXEC = os.path.join(AQUI, "execucoes")
DIR_LOGS = os.path.join(AQUI, "logs")
INI = os.path.join(AQUI, "ci.ini")
BDS_PADRAO = r"C:\Program Files (x86)\Embarcadero\Studio\20.0"


def revisao_svn(dir_wc):
    """Revisao da working copy. Zero se o svn nao responder - a CI nao
    deve morrer por causa disso; o numero serve para rotular a execucao."""
    try:
        saida = subprocess.run(
            ["svn", "info", "--xml", dir_wc],
            capture_output=True, text=True, timeout=30,
        )
    except (OSError, subprocess.SubprocessError):
        return 0
    achado = re.search(r'revision="(\d+)"', saida.stdout or "")
    return int(achado.group(1)) if achado else 0


def filtrar(lista, grupo=None, projeto=None, desde=None):
    if projeto:
        return [p for p in lista if p.nome == projeto]
    if grupo:
        lista = [p for p in lista if p.grupo == grupo]
    if desde:
        nomes = [p.nome for p in lista]
        if desde in nomes:
            lista = lista[nomes.index(desde):]
    return list(lista)


def executar(lista, execucao, dir_exec, dir_bds, dir_logs, tentativas,
             compilar_fn=None, ponteiro=True):
    """Compila a lista, gravando o estado apos cada projeto.

    Falha em projeto base bloqueia o restante DAQUELE grupo - seguir so
    produziria erro em cascata. Falha em folha nao bloqueia ninguem.

    ponteiro=False para compilacao avulsa: grava o proprio arquivo sem virar
    a execucao corrente.
    """
    compilar_fn = compilar_fn or compilador.compilar
    os.makedirs(dir_logs, exist_ok=True)
    grupos_bloqueados = set()
    houve_falha = False

    for p in lista:
        if p.grupo in grupos_bloqueados:
            estado.marcar(execucao, p.nome, "bloqueado")
            estado.gravar(dir_exec, execucao, ponteiro)
            continue

        log = os.path.join(dir_logs, "%s.log" % p.nome)
        dproj = os.path.join(DIR_SERVICES, p.caminho)
        resultado = compilar_fn(dproj, p.modo, log, dir_bds, tentativas)

        if resultado.ok:
            estado.marcar(
                execucao, p.nome, "ok",
                segundos=resultado.segundos,
                tentativas=resultado.tentativas,
                nota=resultado.nota,
            )
        else:
            houve_falha = True
            estado.marcar(
                execucao, p.nome, "falhou",
                segundos=resultado.segundos,
                tentativas=resultado.tentativas,
                erro=resultado.erro,
            )
            if p.base:
                grupos_bloqueados.add(p.grupo)

        estado.gravar(dir_exec, execucao, ponteiro)

    execucao["situacao"] = "concluida_com_falhas" if houve_falha else "concluida"
    estado.gravar(dir_exec, execucao, ponteiro)
    return execucao


def main():
    ap = argparse.ArgumentParser(description="Integracao continua - compilacao Linux (Fase 1).")
    ap.add_argument("--ciclo", action="store_true", help="execucao nova na revisao atual")
    ap.add_argument("--retomar", action="store_true", help="continua a execucao parada")
    ap.add_argument("--grupo", help="compila so um grupo do ci.ini")
    ap.add_argument("--projeto", help="compila so um projeto")
    ap.add_argument("--desde", help="do projeto informado em diante")
    ap.add_argument("--bds", default=BDS_PADRAO, help="pasta do RAD Studio")
    args = ap.parse_args()

    lista = projetos.montar_lista(DIR_SERVICES, INI)
    tentativas = projetos.ler_ini(INI).getint("geral", "tentativas", fallback=2)

    # Compilacao avulsa nao vira a execucao corrente (criterio 7 da spec).
    avulsa = bool(args.grupo or args.projeto or args.desde)

    if args.retomar:
        execucao = estado.carregar_atual(DIR_EXEC)
        if not execucao:
            sys.exit("ERRO: nao ha execucao para retomar.")

        atual = revisao_svn(DIR_SERVICES)
        if atual and atual > execucao["revisao"]:
            print(
                "AVISO: o SVN esta na r%s e a execucao parada e da r%s.\n"
                "       --retomar congela na revisao da execucao. Se voce corrigiu\n"
                "       codigo, a correcao e uma revisao nova: use --ciclo."
                % (atual, execucao["revisao"])
            )

        nomes = {p["nome"] for p in estado.pendentes(execucao)}
        alvo = [p for p in lista if p.nome in nomes]
        print("Retomando r%s: %d projeto(s) restante(s)." % (execucao["revisao"], len(alvo)))
    else:
        alvo = filtrar(lista, grupo=args.grupo, projeto=args.projeto, desde=args.desde)
        if not alvo:
            sys.exit("ERRO: nenhum projeto casou com o filtro informado.")
        revisao = revisao_svn(DIR_SERVICES)
        execucao = estado.criar(revisao, "avulsa" if avulsa else "ciclo", alvo)
        print("Execucao r%s: %d projeto(s)." % (revisao, len(alvo)))

    executar(alvo, execucao, DIR_EXEC, args.bds, DIR_LOGS, tentativas,
             ponteiro=not avulsa)

    falhas = [p for p in execucao["projetos"] if p["status"] == "falhou"]
    bloqueados = [p for p in execucao["projetos"] if p["status"] == "bloqueado"]
    ok = [p for p in execucao["projetos"] if p["status"] == "ok"]
    print("\n%d ok | %d falha(s) | %d bloqueado(s)" % (len(ok), len(falhas), len(bloqueados)))
    for p in falhas:
        print("  FALHOU  %-28s %s" % (p["nome"], p.get("erro", "")[:90]))
    for p in ok:
        if p.get("nota"):
            print("  ATENCAO %-28s %s" % (p["nome"], p["nota"][:90]))
    if falhas or bloqueados:
        print("\nApos corrigir: ci.py --ciclo (codigo novo) ou --retomar (mesma revisao)")
    return 1 if falhas else 0


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 4: Rodar e confirmar que passa**

```
python padra_atualizado\Services\_ci\testes\test_ci.py
```

Esperado: `OK` (8 testes)

- [ ] **Step 5: Rodar a suíte inteira**

```
python -m unittest discover -s padra_atualizado\Services\_ci\testes -p "test_*.py" -v
```

Esperado: `OK` (26 testes)

- [ ] **Step 6: Prova de fogo — um grupo real, do menor para o maior**

```
python padra_atualizado\Services\_ci\ci.py --grupo suprimento
```

Esperado: 3 projetos, todos `ok`. Conferir que `execucoes\r<rev>.json` existe e que há um `.log` por projeto em `logs\`.

Depois, testar a retomada de verdade: rodar `--grupo tintas`, matar com Ctrl+C no meio, e:

```
python padra_atualizado\Services\_ci\ci.py --retomar
```

Esperado: continua do projeto seguinte, sem refazer os anteriores.

- [ ] **Step 7: Commit**

```
svn add padra_atualizado\Services\_ci\ci.py padra_atualizado\Services\_ci\testes\test_ci.py
svn commit -m "Req. ####  CI: CLI, orquestracao e politica base/folha"
```

---

### Task 6: LEIAME e fechamento da fase

**Files:**
- Create: `padra_atualizado/Services/_ci/LEIAME.txt`
- Create: `padra_atualizado/Services/_ci/.svnignore` (para `execucoes/` e `logs/`)

- [ ] **Step 1: Escrever o LEIAME**

Sem acentos, seguindo o formato do `_monitor/LEIAME.txt`. Esqueleto obrigatório:

```
INTEGRACAO CONTINUA - COMPILACAO
=====================

Compila os projetos Delphi para Linux por linha de comando, via MSBuild,
sem depender da IDE aberta.

COMO RODAR
----------
    ci.py --ciclo                  tudo, na ordem, deduplicado
    ci.py --retomar                continua a execucao parada
    ci.py --grupo tintas           so um grupo
    ci.py --projeto AutcomTinta    so um, para investigar
    ci.py --desde TintaGeneral     do projeto X em diante

--RETOMAR OU --CICLO?
---------------------
    --retomar  nada mudou no codigo: maquina reiniciou, falha de ambiente,
               execucao cancelada. Continua na revisao da execucao parada.
    --ciclo    execucao nova na revisao atual. E O CERTO DEPOIS DE CORRIGIR
               CODIGO - a correcao e uma revisao nova.

    Se o SVN estiver a frente da execucao parada, o --retomar avisa. Ele nao
    faz svn update sozinho: reverter a working copy afeta quem esta na maquina.

ONDE FICA O QUE
---------------
    execucoes\r<rev>_<gatilho>.json   estado, gravado apos CADA projeto
    execucoes\atual.json              aponta para a execucao corrente
    logs\<projeto>.log                um log por projeto

    Compilacao avulsa (--projeto, --grupo, --desde) grava o proprio arquivo
    mas NAO vira a execucao corrente - o --ciclo parado continua sendo o que
    o --retomar encontra.

AJUSTES (ci.ini)
---------------------
    [build]  projetos que exigem build completo em vez de make
    [base]   falha neles interrompe o grupo (o resto so daria erro em cascata)
    [pular]  exclusoes temporarias - sempre com motivo e requisito no comentario

    O QUE existe e em que ordem vem dos .groupproj, nao daqui. Projeto novo
    no groupproj entra sozinho.

ARMADILHA CONHECIDA - erro de link intermitente
-----------------------------------------------
    [DCC Error] E2597 ld-linux.exe: fatal error: no input files

    Acontece no AutcomTinta e passa ao recompilar. A causa imediata e o
    arquivo de resposta do linker (bin\auttin\AutcomTinta.lnk) nao existir
    na hora do link. Por isso a CI tenta 2 vezes.

    Quando a 1a tentativa falha e a 2a passa, fica registrado em "nota" no
    estado - falha intermitente que se cura sozinha some do radar se ninguem
    anotar.

    Diagnostico completo e hipoteses ja descartadas:
    IA\specs\459887\spec.md, anexo.
```

- [ ] **Step 2: Ignorar estado e logs no SVN**

`execucoes/` e `logs/` são resultado de execução, não fonte. Não devem ser versionados:

```
svn propset svn:ignore "execucoes
logs
__pycache__" padra_atualizado\Services\_ci
```

- [ ] **Step 3: Rodar um ciclo completo e cronometrar**

```
python padra_atualizado\Services\_ci\ci.py --ciclo
```

Anotar o tempo total e comparar com o ciclo do TestExecute. É o número que decide se a Fase 2 (agendamento) pode entrar já.

- [ ] **Step 4: Conferir os critérios de aceitação**

Percorrer os sete critérios da seção "Critérios de aceitação — Fase 1" da spec, um a um, marcando o que foi verificado e como.

- [ ] **Step 5: Commit**

```
svn add padra_atualizado\Services\_ci\LEIAME.txt
svn commit -m "Req. ####  CI: LEIAME e fechamento da Fase 1"
```

---

## Notas para quem executa

**O `--projeto` e o `--grupo` criam execução própria** e sobrescrevem o `atual.json`. Isso é intencional na Fase 1 — investigar um projeto isolado é a operação mais comum durante o desenvolvimento. Se atrapalhar na prática, o ajuste é gravar execuções parciais num ponteiro separado; não antecipe.

**O `svn commit` de cada tarefa precisa de número de requisito e token do DelphAI** (ver `CLAUDE.md`). Se ainda não houver requisito, acumule os commits e feche todos juntos no fim.

**Se o teste do Step 5 da Task 4 falhar por caminho:** o MSBuild resolve caminhos relativos a partir do diretório corrente do processo, não do `.dproj`. O código passa caminho absoluto justamente por isso — se ainda assim falhar, verifique se `DIR_SERVICES` está apontando para onde você espera.

**Não adicione paralelismo** mesmo que sobre tempo. Enquanto o diretório de unidades for compartilhado por 142 projetos, compilar em paralelo reintroduz contaminação cruzada — e essa é uma classe de bug que já custou um dia desta investigação.
