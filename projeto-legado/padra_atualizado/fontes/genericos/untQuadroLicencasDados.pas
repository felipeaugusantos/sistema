{******************************************************************************}
{* QUADRO DE LICENCAS - DADOS E REGRAS                                        *}
{*                                                                            *}
{* Unica fonte de verdade do quadro de licencas. As duas telas principais      *}
{* consomem daqui:                                                            *}
{*   - versao classica (VCL) : untQuadroLicencas desenha direto do record      *}
{*   - versao nova (FMX)     : recebe IQuadroLicencas por IPrincipalAutcom     *}
{*                                                                            *}
{* Aqui ficam as tres verificacoes do requisito, a leitura da tabela, a faixa  *}
{* de uso e a ordem de exibicao. Nada de desenho - cor e medida sao de cada    *}
{* view, porque TColor da VCL e TAlphaColor do FMX nao sao a mesma coisa.      *}
{******************************************************************************}
unit untQuadroLicencasDados;

interface

uses
  Classes, SysUtils, Principal.View.Interfaces;

Const
  TAB_QDR_LICENCAS = 'CONTROLE_LICENCAS';

  { daqui para cima a faixa vira 'no limite' }
  PRC_LIMITE = 0.85;

  FAIXA_ACIMA      = 0;
  FAIXA_NO_LIMITE  = 1;
  FAIXA_DENTRO     = 2;
  FAIXA_SEM_LIMITE = 3;

Type
  TdtoLicenca = Record
    strIdProduto  : String;
    intContratadas: Integer;
    intUtilizadas : Integer;
    dtaDataBase   : TDate;
    dtaUltAtu     : TDateTime;
    fltUso        : Double;   { utilizadas / contratadas; zero quando nao ha limite }
    intFaixa      : Integer;  { FAIXA_ACIMA, FAIXA_NO_LIMITE, FAIXA_DENTRO, FAIXA_SEM_LIMITE }
  End;

  TarrLicencas = TArray<TdtoLicenca>;

  {*** carga: sem instancia, sem tempo de vida para administrar ***}
  TCargaLicencas = Class(TObject)
  Public
    { Confere, na ordem do requisito: direito do operador, existencia da tabela e }
    { existencia de registro. Falso em qualquer uma delas, e o quadro nao aparece. }
    class function fCarregar(Const AstrCodOpe: String;
                             Out AarrLicencas: TarrLicencas;
                             Out AintAcima: Integer): Boolean;
  End;

  {*** implementacoes de interface, para a view FMX ***}
  TLicencaProdutoInfo = Class(TInterfacedObject, ILicencaProduto)
  Private
    FdtoLic: TdtoLicenca;
  Public
    Constructor Create(Const AdtoLic: TdtoLicenca);
    function Produto: String;
    function Contratadas: Integer;
    function Utilizadas: Integer;
    function DataBase: TDateTime;
    function Faixa: Integer;
    function PercentualUso: Double;
  End;

  TQuadroLicencasInfo = Class(TInterfacedObject, IQuadroLicencas)
  Private
    FarrLicencas: TarrLicencas;
    FintAcima   : Integer;
    FblnVisivel : Boolean;
  Public
    Constructor Create(Const AstrCodOpe: String);
    function Visivel: Boolean;
    function Itens: TArray<ILicencaProduto>;
    function QtdAcimaDoLimite: Integer;
  End;

implementation

uses
  Variants, Uni, untFuncoesSimples;

Const
  { Uma linha por produto, na data-base mais recente DELE. A UNIQUE KEY        }
  { ( ID_PRODUTO, DATA_BASE ) garante exatamente um registro por produto.      }
  { Com MAX(DATA_BASE) global, produto cujo coletor parou desapareceria.       }
  {                                                                            }
  { O filtro de utilizadas fica na consulta externa, e nao na subconsulta:     }
  { aqui ele esconde o produto sem uso na ultima data-base; la dentro faria    }
  { voltar a data anterior em que houve uso, mostrando numero velho como se    }
  { fosse o de hoje.                                                           }
  SQL_LICENCAS =
    ' SELECT CL.ID_PRODUTO, '                                                  +
    '        CL.QTD_LIC_CONTRATADAS, '                                         +
    '        CL.QTD_LIC_UTILIZADAS, '                                          +
    '        CL.DATA_BASE, '                                                   +
    '        CL.ULT_ATUALIZACAO '                                              +
    ' FROM CONTROLE_LICENCAS CL '                                              +
    ' INNER JOIN ( SELECT ID_PRODUTO, MAX(DATA_BASE) AS DATA_BASE '            +
    '              FROM CONTROLE_LICENCAS '                                    +
    '              GROUP BY ID_PRODUTO ) UL '                                  +
    '         ON UL.ID_PRODUTO = CL.ID_PRODUTO '                               +
    '        AND UL.DATA_BASE  = CL.DATA_BASE '                                +
    ' WHERE CL.QTD_LIC_UTILIZADAS > 0 '                                        +
    ' ORDER BY CL.ID_PRODUTO ';

{*******************************************}
{* MASTER E O OPERADOR COM OPE_SENLIB = N  *}
{* EM CADOPE: quem nao precisa informar    *}
{* senha para liberar trava do sistema.    *}
{* Nao depende de DIROPE nem de DIRGPO.    *}
{*******************************************}
function fEhOperadorMaster(Const AstrCodOpe: String): Boolean;
begin
  { mesmo helper que untLiberacao usa para ler este campo. VarToStr porque a
    coluna aceita nulo, e comparar Variant nulo com string levanta excecao -
    e nulo nao e master. }
  Result := VarToStr(fCampoTabela('OPE_SENLIB', 'CADOPE',
                                  ['OPE_CODOPE'], [AstrCodOpe])) = 'N';
end;

{*******************************************}
{* PRIMEIRO QUEM TEM PROBLEMA: ACIMA, NO   *}
{* LIMITE, DENTRO, E POR FIM SEM LIMITE    *}
{*******************************************}
procedure pOrdenar(Var AarrLicencas: TarrLicencas);
  Var
    intI    : Integer;
    intJ    : Integer;
    dtoAux  : TdtoLicenca;
    blnTroca: Boolean;
begin
  For intI := 0 To High(AarrLicencas) - 1 Do
  Begin
    For intJ := 0 To High(AarrLicencas) - 1 - intI Do
    Begin
      blnTroca := False;

      If AarrLicencas[intJ].intFaixa > AarrLicencas[intJ + 1].intFaixa Then
        blnTroca := True
      Else If AarrLicencas[intJ].intFaixa = AarrLicencas[intJ + 1].intFaixa Then
      Begin
        If AarrLicencas[intJ].fltUso < AarrLicencas[intJ + 1].fltUso Then
          blnTroca := True
        Else If AarrLicencas[intJ].fltUso = AarrLicencas[intJ + 1].fltUso Then
          blnTroca := CompareText(AarrLicencas[intJ].strIdProduto,
                                  AarrLicencas[intJ + 1].strIdProduto) > 0;
      End;

      If blnTroca Then
      Begin
        dtoAux                    := AarrLicencas[intJ];
        AarrLicencas[intJ]        := AarrLicencas[intJ + 1];
        AarrLicencas[intJ + 1]    := dtoAux;
      End;
    End;
  End;
end;

{ TCargaLicencas }

class function TCargaLicencas.fCarregar(Const AstrCodOpe: String;
                                        Out AarrLicencas: TarrLicencas;
                                        Out AintAcima: Integer): Boolean;
  Var
    qryLic: TUniQuery;
    intQtd: Integer;
    dtoLic: TdtoLicenca;
begin
  SetLength(AarrLicencas, 0);
  AintAcima := 0;
  Result    := False;
  intQtd    := 0;

  { 1. operador master }
  If fEmptyStr(AstrCodOpe) Then
    Exit;

  If Not fEhOperadorMaster(AstrCodOpe) Then
    Exit;

  { 2. a tabela existe no schema }
  If Not fTabelaExiste(TAB_QDR_LICENCAS, True) Then
    Exit;

  { 3. ha registro nela }
  qryLic := fCriaQuery(Nil);
  Try
    qryLic.SQL.Text := SQL_LICENCAS;
    qryLic.Open;

    While Not qryLic.Eof Do
    Begin
      dtoLic.strIdProduto   := qryLic.FieldByName('ID_PRODUTO').AsString;
      dtoLic.intContratadas := qryLic.FieldByName('QTD_LIC_CONTRATADAS').AsInteger;
      dtoLic.intUtilizadas  := qryLic.FieldByName('QTD_LIC_UTILIZADAS').AsInteger;
      dtoLic.dtaDataBase    := qryLic.FieldByName('DATA_BASE').AsDateTime;
      dtoLic.dtaUltAtu      := qryLic.FieldByName('ULT_ATUALIZACAO').AsDateTime;

      If dtoLic.intContratadas > 0 Then
      Begin
        dtoLic.fltUso := dtoLic.intUtilizadas / dtoLic.intContratadas;

        If dtoLic.fltUso > 1 Then
        Begin
          dtoLic.intFaixa := FAIXA_ACIMA;
          Inc(AintAcima);
        End
        Else If dtoLic.fltUso >= PRC_LIMITE Then
          dtoLic.intFaixa := FAIXA_NO_LIMITE
        Else
          dtoLic.intFaixa := FAIXA_DENTRO;
      End
      Else
      Begin
        { zero, negativo ou nulo: o cliente nao tem limite contratado }
        dtoLic.fltUso   := 0;
        dtoLic.intFaixa := FAIXA_SEM_LIMITE;
      End;

      { cresce em bloco: SetLength a cada linha realoca e copia o array inteiro }
      If intQtd = Length(AarrLicencas) Then
        SetLength(AarrLicencas, intQtd + 16);

      AarrLicencas[intQtd] := dtoLic;
      Inc(intQtd);

      qryLic.Next;
    End;

    { devolve a folga do ultimo bloco: daqui para baixo Length e a contagem real }
    SetLength(AarrLicencas, intQtd);

    qryLic.Close;
  Finally
    FreeAndNil(qryLic);
  End;

  Result := Length(AarrLicencas) > 0;

  If Result Then
    pOrdenar(AarrLicencas);
end;

{ TLicencaProdutoInfo }

Constructor TLicencaProdutoInfo.Create(Const AdtoLic: TdtoLicenca);
begin
  Inherited Create;

  FdtoLic := AdtoLic;
end;

function TLicencaProdutoInfo.Produto: String;
begin
  Result := FdtoLic.strIdProduto;
end;

function TLicencaProdutoInfo.Contratadas: Integer;
begin
  Result := FdtoLic.intContratadas;
end;

function TLicencaProdutoInfo.Utilizadas: Integer;
begin
  Result := FdtoLic.intUtilizadas;
end;

function TLicencaProdutoInfo.DataBase: TDateTime;
begin
  Result := FdtoLic.dtaDataBase;
end;

function TLicencaProdutoInfo.Faixa: Integer;
begin
  Result := FdtoLic.intFaixa;
end;

function TLicencaProdutoInfo.PercentualUso: Double;
begin
  Result := FdtoLic.fltUso;
end;

{ TQuadroLicencasInfo }

Constructor TQuadroLicencasInfo.Create(Const AstrCodOpe: String);
begin
  Inherited Create;

  FblnVisivel := TCargaLicencas.fCarregar(AstrCodOpe, FarrLicencas, FintAcima);
end;

function TQuadroLicencasInfo.Visivel: Boolean;
begin
  Result := FblnVisivel;
end;

function TQuadroLicencasInfo.QtdAcimaDoLimite: Integer;
begin
  Result := FintAcima;
end;

function TQuadroLicencasInfo.Itens: TArray<ILicencaProduto>;
  Var
    intI: Integer;
begin
  SetLength(Result, Length(FarrLicencas));

  For intI := 0 To High(FarrLicencas) Do
    Result[intI] := TLicencaProdutoInfo.Create(FarrLicencas[intI]);
end;

end.
