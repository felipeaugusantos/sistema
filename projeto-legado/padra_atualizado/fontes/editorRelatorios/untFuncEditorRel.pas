unit untFuncEditorRel;

interface

uses Classes, Windows, Forms, SysUtils, Dialogs, Controls, frxClass,
  System.Variants, untTypesSistema, TypesRel, untFuncoesSimples,
  untFuncoesEditorFast, dxCore,
  Uni, UniClientDataSet, UniDataSetProvider, untZClient,
  DB, untConstantes,
  Vcl.Graphics, System.StrUtils;

Type
   TTipoInterface = (facString, facFloat, facInteger, facDocumento, facTabelaPreco, facTabelaPrecoLista, facDate, facDiaMes, facMesAno, facAno,
                     facConPag, facCPF, facCNPJ, facLotOP, facEspDoc, facHoraMinSeg, facPlaVei, facCheckBox, facComboBox, facComboBoxVerdeVermelho, facRadioGroup,
                     facCustomCheckList);

   TMascara = (masVazio, masCEP, masCNPJ, masCondPagto, masContabil, masPlacaVeiculo, masPlanoContabil, masDecQtd, masEstDec, masDeqTpc, masTelefone, masDecUni);

   TVisibilidade = (visSempre, visTabelaPreco1, visTabelaPreco2, visTabelaPreco3,
                    visTabelaPreco4, visTabelaPreco5, visTabelaPreco6, visTabelaPreco7,
                    visUsaTintaMaquina,visENTFUT,visUSAPDV,visPDEOR,visCTLEST,visCADLOC,visUTIWMS,
                    visEMBSEPs,visEMBSEPn);

   TTipoConfig = (cfgAutcom, cfgSPED);

   TArrExprValida = Array Of Record
     strExpres: string;
     blnValida: Boolean;
     strStrRes: string;
   End;

   TMontagemGrid = (mntGrid, mntTotais, mntExcelGrid, mntExcel);

   TTipoCabecalho = (caEmpresa, caTitulo, caFiltro);

   TCabecalhoGrid = Record
     strCabecalho: String;
     taAlinhamento: TAlignment;
     caTipo: TTipoCabecalho;
   End;

   TArrCabecalhoGrid = Array Of TCabecalhoGrid;

   TControleRel = Record
    strMaster,
    strComple,
    strNomCam,
    strCamLig: String;
    blnChild,
    blnCompPri,
    blnPrint: Boolean;
    intExcel: Integer;
    sltFiltros: TStringList;
  End;

  TArrControleRel = Array Of TControleRel;

Const
  STR_PAGINA_INICIAL = 'PAGINA_INICIAL';
  STR_PRECUS = 'VS_FLTPRECUS';
  LIMITE_MODELO_USUARIO = '500000';
  MAX_LINHAS_DETALHE = 5;
  MAX_TOTAL = 11;
  MAX_NOME_TOTAL  = 30;
  INT_ESPACAMENTO_COLUNAS_JATO = 5;
  INT_ESPACAMENTO_COLUNAS_MATRICIAL = 9.6;

  STR_DEF_FORMULA = 'Definir Fórmula';

  INT_SERIE = 1;
  INT_LEGENDA = 2;
  INT_DRILLUP = 3;

   ArrTipoTotal: Array[0..MAX_TOTAL] Of String =
                     ('',
                      'SUM',
                      'MAX',
                      'MIN',
                      'AVG',
                      'COUNT',
                      'TRUNC',
                      'ROUND',
                      'ABS',
                      'INT',
                      'SQRT',
                      '');

   ArrDesTotal: Array[0..MAX_TOTAL] Of String[MAX_NOME_TOTAL] =
                     ('',
                      'Soma',
                      'Máximo',
                      'Mínimo',
                      'Média',
                      'Contagem',
                      'Truncagem',
                      'Arredondamento',
                      'Valor Absoluto',
                      'Parte Inteira',
                      'Raiz Quadrada',
                      STR_DEF_FORMULA);

   ArrDesMascara: Array[masVazio..masDecUni] Of String =
                     ('',
                      'C.E.P.',
                      'C.N.P.J/C.P.F.',
                      'Condição de Pagamento',
                      'Máscara Contábil',
                      'Placa de Veículo',
                      'Plano Contábil',
                      'Quantidade (CFG_QTDDEC)',
                      'Quantidade (CFG_ESTDEC)',
                      'Quantidade (CFG_DEQTPC)',
                      'Telefone',
                      'Valor (CFG_DECUNI)');

   ArrTipoParametro: Array[facString..facPlaVei] Of TFieldType =
                     (ftString,
                      ftFloat,
                      ftInteger,
                      ftString,
                      ftString,
                      ftString,
                      ftDate,
                      ftString,
                      ftString,
                      ftString,
                      ftString,
                      ftString,
                      ftString,
                      ftString,
                      ftString,
                      ftString,
                      ftString);

   ArrDesInterface: Array[facString..facCustomCheckList] Of String =
                     ('Texto',
                      'Número decimal',
                      'Número inteiro',
                      'Número de Documento',
                      'Tabela de Preço',
                      'Tabela de Preço (Lista)',
                      'Data',
                      'Data (Dia/Mês)',
                      'Data (Mês/Ano)',
                      'Data (Ano)',
                      'Condição de Pagamento',
                      'CPF',
                      'CNPJ',
                      'Lote de Ordem de Produção',
                      'Espécie de Documento',
                      'Horário',
                      'Placa de Veículo',
                      'CheckBox',
                      'ComboBox',
                      'ComboBox Verde/Vermelho',
                      'RadioGroup',
                      'CheckList Customizado');

   ArrDesConfig: Array[cfgAutcom..cfgSPED] Of String =
                     ('AUTCOM',
                      'SPED');

   ArrDesParametro: Array[facString..facPlaVei] Of String =
                     ('Texto',
                      'Número decimal',
                      'Número inteiro',
                      'Número de Documento',
                      'Tabela de Preço',
                      'Tabela de Preço (Lista)',
                      'Data',
                      'Data (Dia/Mês)',
                      'Data (Mês/Ano)',
                      'Data (Ano)',
                      'Condição de Pagamento',
                      'CPF',
                      'CNPJ',
                      'Lote de Ordem de Produção',
                      'Espécie de Documento',
                      'Horário',
                      'Placa de Veículo');

   ArrDesVisibilidade: Array[visSempre..visEMBSEPn] Of String =
                     ('Sempre',
                      'Tabela de Preço 1 Ativa',
                      'Tabela de Preço 2 Ativa',
                      'Tabela de Preço 3 Ativa',
                      'Tabela de Preço 4 Ativa',
                      'Tabela de Preço 5 Ativa',
                      'Tabela de Preço 6 Ativa',
                      'Tabela de Preço 7 Ativa',
                      'Utiliza Tinta de Máquina',
                      'CFG_ENTFUT = S',
                      'CFG_USAPDV = S',
                      'CFG_USAPDV = S and CFG_ORDPRO = S',
                      'CFG_CTLEST = 2',
                      'CFG_CADLOC = S',
                      'Utiliza WMS',
                      'CFG_EMBSEP = S',
                      'CFG_EMBSEP = N'
                      );

Type
  TDestinoRel = (desVideo, desImpressora, desPDF, desCSV, desEmail, desTXT, desExcel,
                 desTrace, desDesignReport, desXML,
                 desValidacao,
                 desGraficoColunas,
                 desGraficoLinha,
                 desGraficoBarras,
                 desGraficoTorta,
                 desGraficoArea,
                 desGraficoColunasEmpilhado,
                 desGraficoBarrasEmpilhado,
                 desGraficoAreaEmpilhado,
                 desGrid,
                 desCardDashboard,
                 desGridDashboard,
                 desGraficoLinhaDashboard,
                 desGraficoBarrasDashboard,
                 desGraficoBarrasEmpilhadasDashboard,
                 desGraficoColunasDashboard,
                 desGraficoColunasEmpilhadasDashboard,
                 desGraficoAreaDashboard,
                 desGraficoAreaEmpilhadoDashboard,
                 desGraficoTortaDashboard,
                 desGraficoVelocimetroDashboard,
                 desArquivoSaida);

  TFuncaoAutcom = (funVazio,
                   funDescricaoLinhaWandaPro,
                   funNomeTinta,
                   funCalculaJurosCadCtr);

  TAfterPost = Procedure(dataSet: TDataSet) Of Object;

  TArrQuery  = Array Of TUniQuery;
  TArrClient = Array Of TZClient;
  TArrDataSet= Array Of TDataSet;

  TArrUniClient = Array Of TUniClientDataSet;
  TArrProvider = Array Of TUniDataSetProvider;
  TArrBoolean = Array Of Boolean;

Const
  SET_GRAFICO = [desGraficoColunas,
                 desGraficoLinha,
                 desGraficoBarras,
                 desGraficoTorta,
                 desGraficoArea,
                 desGraficoColunasEmpilhado,
                 desGraficoBarrasEmpilhado,
                 desGraficoAreaEmpilhado];

  SET_GRAFICO_DASH = [desCardDashboard,
                      desGridDashboard,
                      desGraficoLinhaDashboard,
                      desGraficoBarrasDashboard,
                      desGraficoBarrasEmpilhadasDashboard,
                      desGraficoColunasDashboard,
                      desGraficoColunasEmpilhadasDashboard,
                      desGraficoAreaDashboard,
                      desGraficoAreaEmpilhadoDashboard,
                      desGraficoTortaDashboard,
                      desGraficoVelocimetroDashboard];

   ArrDestino: Array[desVideo..desArquivoSaida] Of String[50] =
                     ('Vídeo',
                      'Impressora',
                      'PDF',
                      'CSV',
                      'e-Mail',
                      'TXT',
                      'Excel',
                      'Trace',
                      'DesignReport',
                      'XML',
                      'Validação',
                      'Gráfico de Colunas',
                      'Gráfico de Linha',
                      'Gráfico de Barras',
                      'Gráfico de Torta',
                      'Gráfico de Área',
                      'Gráfico de Colunas Emplilhado',
                      'Gráfico de Barras Emplihado',
                      'Gráfico de Área Emplihado',
                      'Grid',
                      'Card  Dashboard',
                      'Grid Dashboard',
                      'Gráfico de Linha Dashboard',
                      'Gráfico de Barras Dashboard',
                      'Gráfico de Barras Empilhado Dashboard',
                      'Gráfico de Barras Horiz. Dashboard',
                      'Gráfico de Barras Horiz. Empilhado Dashboard',
                      'Gráfico de Área Dashboard',
                      'Gráfico de Área Emplihado Dashboard',
                      'Gráfico de Torta Dashboard',
                      'Gráfico de Velocímetro Dashboard',
                      'Arquivo Saída');

   ArrDesFuncao: Array[funVazio..funCalculaJurosCadCtr] Of String =
                     ('',
                      'Descrição da Linha WandaPro',
                      'Nome da Tinta',
                      'Valor da duplicata acrescido de juros');

   ArrDesDefFuncao: Array[funVazio..funCalculaJurosCadCtr] Of String =
                     ('',
                      'fDescricaoLinhaWandaPro',
                      'fNomeTinta',
                      'fCalculaJurosCadCtr');

   ArrDesParametrosFuncao: Array[funVazio..funCalculaJurosCadCtr] Of String =
                                 ('',
                                  'Código da Linha',

                                  'Identificação da Tinta',

                                  'Data de Vencimento da Duplicata' + #13#10 +
                                  'Data de Recebimento da Duplicata' + #13#10 +
                                  'Valor da Duplicata');

function fSVN_RevisionEditorRel: String;

Function fRetTiposPapel: String;
Function fRetPaperSize(strNomPap: String): Integer;

procedure dxInitializeRel;
procedure dxFinalizeRel;

Function fUpper(strInfo: String): String;

function Split(const strTexto: string; chrDelimitador : Char): TStringList;

implementation

procedure dxInitializeRel;
Begin
  dxInitialize;
End;

procedure dxFinalizeRel;
Begin
  dxFinalize;
End;

function fSVN_RevisionEditorRel: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

Function fRetTiposPapel: String;
  Var
    stlLista: TStringList;
Begin
  stlLista := TStringList.Create;
  stlLista.Add('A4');
  stlLista.Add('A5');
  stlLista.Add('Carta');
  stlLista.Add('Executivo');
  stlLista.Add('Ofício');
  stlLista.Add('T40');

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Function fRetPaperSize(strNomPap: String): Integer;
Begin
  Result := 9;
  If SameText(strNomPap, 'A4') Then
    Result := 9

  Else If SameText(strNomPap, 'A5') Then
   Result := 11

  Else If SameText(strNomPap, 'Carta') Then
   Result := 1

  Else If SameText(strNomPap, 'Executivo') Then
   Result := 7

  Else If SameText(strNomPap, 'Ofício') Then
   Result := 5

  Else If SameText(strNomPap, 'T40') Then
   Result := 256;
End;

Function fUpper(strInfo: String): String;
  Const
		ComAcento = 'àâêôûãõáéíóúçü´';
  Var
    intContador: Integer;
Begin
  Result := UpperCase(strInfo);

  For intContador := 1 To Length(strInfo) Do
    Case Result[intContador] Of
      'à': Result[intContador] := 'À';
      'â': Result[intContador] := 'Â';
      'ê': Result[intContador] := 'Ê';
      'ô': Result[intContador] := 'Ô';
      'û': Result[intContador] := 'Û';
      'ã': Result[intContador] := 'Ã';
      'õ': Result[intContador] := 'Õ';
      'á': Result[intContador] := 'Á';
      'é': Result[intContador] := 'É';
      'í': Result[intContador] := 'Í';
      'ó': Result[intContador] := 'Ó';
      'ú': Result[intContador] := 'Ú';
      'ç': Result[intContador] := 'Ç';
      'ü': Result[intContador] := 'Ü';
    End;
End;

function Split(const strTexto: string; chrDelimitador : Char): TStringList;
begin
  Result := TStringList.Create;
  Result.Delimiter := chrDelimitador;
  Result.StrictDelimiter := True;
  Result.DelimitedText := strTexto;

  //Result.LineBreak := chrDelimitador;
  //Result.Text := strTexto;
end;

end.
