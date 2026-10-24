unit untImpContratoLocacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxExportCSVTestabilidade,
  Data.DB, MemDS, DBAccess, Uni, System.MaskUtils, untTypesSistema;

type
  TfrmImpContratoLocacao = class(TForm)
    frxReport1: TfrxReport;
  private
    function fRetornaSeqContrato(strEspDoc, strEmpDoc, strNumDoc: String;
      strCodCli: String): String;
  public
    { Public declarations }
    strNomeArquivo: String;

    procedure pImprimeContratoLocacao(strEspDoc, strEmpDoc, strNumDoc, strCodCli: string;
      blnGerarPDF, blnEnviarEmail: Boolean; blnVisualizar: Boolean);
  end;

implementation

uses
  untFuncoesSimples, cadastro.Model.ContratoLocacaoEquipamentos,
  faturamento.Classes.FaturamentoLocEqu, untFuncoes;

{$R *.dfm}

{ TfrmImpContratoLocacao }

function TfrmImpContratoLocacao.fRetornaSeqContrato(strEspDoc, strEmpDoc,
  strNumDoc: String; strCodCli: String): String;
var
  qry: TUniQuery;
begin
  Result := EmptyStr;
  qry := fCriaQuery();
  Try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EQF_SEQCON FROM EQLFAT  ' +
                '  INNER JOIN CONEQL ON EQF_SEQCON = CONEQL.AUTOINCREM ' +
                'WHERE EQF_ESPDOC = :EQF_ESPDOC ' +
                '  AND EQF_EMPDOC = :EQF_EMPDOC ' +
                '  AND EQF_NUMDOC = :EQF_NUMDOC ' +
                '  AND EQL_CODCLI = :EQL_CODCLI ' +
                '  LIMIT 1 ');

    qry.ParamByName('EQF_ESPDOC').AsString := strEspDoc;
    qry.ParamByName('EQF_EMPDOC').AsString := strEmpDoc;
    qry.ParamByName('EQF_NUMDOC').AsString := strNumDoc;
    qry.ParamByName('EQL_CODCLI').AsString := strCodCli;
    qry.Open;

    If Not qry.IsEmpty Then
      Result := qry.FieldByName('EQF_SEQCON').AsString;
  Finally
    FreeAndNil(qry);
  End;
end;

procedure TfrmImpContratoLocacao.pImprimeContratoLocacao(strEspDoc, strEmpDoc, strNumDoc, strCodCli: string;
  blnGerarPDF, blnEnviarEmail: Boolean; blnVisualizar: Boolean);
var
  objImpressao: TImpressaoFatLocacao;
  objContrato: TContratoLocacaoEquipamentos;
begin
  strNomeArquivo := EmptyStr;
  objContrato := TContratoLocacaoEquipamentos.Create();
  objContrato.fCarregarContrato(fRetornaSeqContrato(strEspDoc, strEmpDoc, strNumDoc, strCodCli), '', True);
  objImpressao := TImpressaoFatLocacao.Create('frmFaturaLocEqu');
  objImpressao.blnVisualizar := blnVisualizar;
  Try
    If Not objImpressao.fAddFatura(objContrato,
                                   strEspDoc,
                                   strEmpDoc,
                                   strNumDoc) Then
    Begin
      If Not fEmptyStr(objImpressao.strMensagemRetorno) Then
      Begin
        fMensagem('ATENÇÃO', objImpressao.strMensagemRetorno, ['&Ok']);
        Exit;
      End;
    End;

    If (blnGerarPDF Or blnEnviarEmail) Then
    Begin
      If objImpressao.fImprmirReciboFat(tpaPDF) Then
      Begin
        If blnEnviarEmail Then
        Begin
          fDisparaEmailAutomatico(strNumDoc, strEspDoc, strEspDoc, '',
                                  'RL', '',  strCodCli,  '', '', TGeraArquivoAnexoEmail.fNew(objImpressao.strNomArq));
        End;
      End
      Else
        If Not fEmptyStr(objImpressao.strMensagemRetorno) Then
          fMensagem('ATENÇÃO', objImpressao.strMensagemRetorno, ['&Ok']);
    End;

    If blnVisualizar Then
    Begin
      If (Not objImpressao.fImprmirReciboFat(tpaNormal)) Then
      Begin
        If Not fEmptyStr(objImpressao.strMensagemRetorno) Then
          fMensagem('ATENÇÃO', objImpressao.strMensagemRetorno, ['&Ok']);
      End;
    End;

    strNomeArquivo := objImpressao.strNomArq;

  Finally
    FreeAndNil(objImpressao);
    FreeAndNil(objContrato);
  End;

end;

end.
