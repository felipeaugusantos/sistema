unit untImpMsgEnv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, frxDMPExport,
  frxBarcode;

type
  TfrmImpMsgEnv = class(TForm)
    frxReportM: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxRelatorio: TfrxDBDataset;
    frxReportJ: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pImprimeMsg(strCodigo, strOpeEnv, strOpeRec, strDtaEnv, strHorEnv, strMsgTit,
      strMensag, strNomForm: String);
  end;

var
  frmImpMsgEnv: TfrmImpMsgEnv;

implementation

{$R *.dfm}
uses
  untFuncoesSimples, Uni, StrUtils;
{ TfrmImpMsgEnv }

procedure TfrmImpMsgEnv.pImprimeMsg(strCodigo, strOpeEnv, strOpeRec, strDtaEnv,
  strHorEnv, strMsgTit, strMensag, strNomForm: String);
Var
    strNomFil: String;
    strTipImp: String;
    strCodBar: String;
    frxRel: TfrxReport;
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery();
  Try
    Try
      pCarregaConfImpr(qryCfgRel, strNomForm);
      If not fPreImpressao(qryCfgRel, strNomFil, strTipImp, False) Then
        Exit;

      If strTipImp = 'J' Then
      Begin
        frxRel := frxReportJ;

        If (fCfgSis('BARMSG', VarBoolean)) Then
        Begin
          strCodBar := '1';                                  //valor 1 fixo
          strCodBar := strCodBar + fStrZero(strCodigo, 12);  //codigo da mensagem com 12 dígitos
          strCodBar := strCodBar + '25';                     //espécie da mensagem (25 representa a mensagem)
          strCodBar := strCodBar + VS_strCodEmp;             //código da empresa.

          TfrxBarCodeView(frxRel.FindObject('barCodBar')).Visible := True;
          TfrxBarCodeView(frxRel.FindObject('barCodBar')).Text    := fGeraCodBarraEAN39(strCodBar);
        End
        Else
          TfrxBarCodeView(frxRel.FindObject('barCodBar')).Visible := False;
      End
      Else
        frxRel := frxReportM;

      frxRel.PrintOptions.Printer   := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\','');
      frxRel.Script.Variables['NUMERO'] := 'No.:     ' + strCodigo;
      frxRel.Script.Variables['OPEENV'] := 'DE:      ' + strOpeEnv + '-' + fRetNomVendRep(strOpeEnv);
      frxRel.Script.Variables['OPEREC'] := 'PARA:    ' + strOpeRec + '-' + fRetNomVendRep(strOpeRec);
      frxRel.Script.Variables['DTAEMI'] := 'EMISSAO: ' + strDtaEnv + ' ' + strHorEnv;
      frxRel.Script.Variables['MSGTIT'] := 'ASSUNTO: ' + strMsgTit;
      frxRel.Script.Variables['MENSAG'] := strMensag;

      If frxRel.PrepareReport Then
        pPrintReport(strNomForm, 'Impressão de Mensagens Recebidas/Enviadas', strNomFil, frxRel);
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmImpMsgEnv.pImprimeMsg]');
    End;
  Finally
    FreeAndNil(qryCfgRel);
  End;
end;

end.
