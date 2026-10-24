unit untRelEntConferencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, UniClientDataSet,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelEntConferencia = class(TfrmPaiRelatorio)
    rdgOpcao: TRadioGroup;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    frxdbCriticas: TfrxDBDataset;
    frxReportJMotorola: TfrxReport;
    frxReportM_Modelo2: TfrxReport;
    frxReportJ_Modelo2: TfrxReport;
    frxReportJ_Modelo3: TfrxReport;
    frxReportM_Modelo3: TfrxReport;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strNumPed,
    strFornec,
    strCodCfr,
    strNomRel: String;
    blnMostraQuantidades: Boolean;
    blnTelaColetor: Boolean;
    cdsCriticas: TUniClientDataSet;
    blnEhConferenciaDePedido: Boolean;
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmRelEntConferencia.btnImprimirClick(Sender: TObject);
  Var
    frxReport: TfrxReport;
    strModRel: String;
begin
  inherited;

  If blnImprime Then
  Begin
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;
    Application.ProcessMessages;

    Try

      Case rdgOpcao.ItemIndex Of
        0: Begin
             cdsCriticas.Filter := 'QTDITE <> QTDCON';
             cdsCriticas.Filtered := TRUE;
           End;
        1: cdsCriticas.Filtered := FALSE;
      End;

      cdsCriticas.IndexFieldNames := 'DESITE';
      strModRel := fCfgSis('MODRIN', varString);

      If blnTelaColetor then
      begin
        If edtDestino.Text = 'V' Then
        	frxReport := frxReportJMotorola
        else
        begin
          if strModRel = '1' then
   	        frxReport := frxReportJ
          Else If strModRel = '3' then
            frxReport := frxReportJ_Modelo3
          Else
          Begin
            frxReport := frxReportJ_Modelo2;

            If blnEhConferenciaDePedido Then
            Begin
              TfrxMemoView(frxReport.FindObject('Memo19')).Visible := False;
              TfrxMemoView(frxReport.FindObject('Memo18')).Visible := False;
            End;
          End;

  	      TfrxMemoView(frxReport.FindObject('mmoDetalhe')).Highlight.Color := fCfgSis('CORZEB');
        end;
      end
      else
      begin
        If strTipImp = 'M' Then
        Begin
          if strModRel = '1' then
             frxReport := frxReportM
          Else If strModRel = '3' then
             frxReport := frxReportM_Modelo3
          Else
            frxReport := frxReportM_Modelo2
        End
        Else
        Begin
          if strModRel = '1' then
   	        frxReport := frxReportJ
          Else If strModRel = '3' then
            frxReport := frxReportJ_Modelo3
          Else
          Begin
            frxReport := frxReportJ_Modelo2;

            If blnEhConferenciaDePedido Then
            Begin
              TfrxMemoView(frxReport.FindObject('Memo19')).Visible := False;
              TfrxMemoView(frxReport.FindObject('Memo18')).Visible := False;
            End;
          End;

          TfrxMemoView(frxReport.FindObject('mmoDetalhe')).Highlight.Color := fCfgSis('CORZEB');
        End;
      end;

      frxReport.Script.Variables['blnMostraQuantidades'] := blnMostraQuantidades;
      frxReport.Script.Variables['NOMREL'] := strNomRel;
      frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxReport.Script.Variables['PEDIDO'] := strNumPed;
      frxReport.Script.Variables['LOJA']   := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
      frxReport.Script.Variables['FORNECEDOR'] := strFornec;
      frxReport.Script.Variables['CONFERENTE'] := strCodCfr + ' - ' + fRetNomeOperador(strCodCfr);

      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxReport)
      Else
        If frxReport.PrepareReport Then
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);

    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmRelEntConferencia.btnImprimirClick]');
      End;
    End;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

end;

procedure TfrmRelEntConferencia.FormShow(Sender: TObject);
begin
  inherited;

  frxdbCriticas.DataSet := cdsCriticas;

  pSetFocus(rdgOpcao.Controls[0] As TWinControl);

  rdgOpcao.Enabled := blnMostraQuantidades;

  If fEmptyStr(strNomRel) Then
    strNomRel := 'INCONSISTENCIAS DA CONFERENCIA';
end;

procedure TfrmRelEntConferencia.FormCreate(Sender: TObject);
begin
  inherited;
  blnMostraQuantidades := True;
  blnEhConferenciaDePedido := False;
end;

procedure TfrmRelEntConferencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : Close;
    VK_RETURN : If ActiveControl Is TRadioButton Then
                  SelectNext(ActiveControl,TRUE, TRUE);
  End;

end;

end.
