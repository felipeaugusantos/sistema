unit untEmailMarketingSelecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untZClient, untHelperCitel,
  cxLookAndFeelPainters, cxStyles, cxProgressBar, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, cxTextEdit, System.ImageList, Vcl.ImgList, cxGridDBDataDefinitions,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TTipoMarcacao    = (tmMarcarTodos, tmDesmarcarTodos, tmMarcarEmailNFe, tmMarcarEmail1, tmMarcarEmail2);

  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TcxPainterAccess = class(TcxGridTableDataCellPainter);

  TfrmEmailMarketingSelecao = class(TfrmPaiConfirma)
    cxgEmailsLevel: TcxGridLevel;
    cxgEmailsTableView: TcxGridDBTableViewCitel;
    cxgEmails: TcxGridCitel;
    cxgEmailsNOME: TcxGridDBColumn;
    cxgEmailsEmail: TcxGridDBColumn;
    cxgEmailsEmail2: TcxGridDBColumn;
    cxgEmailsEmail3: TcxGridDBColumn;
    cxgEmailsMARCA: TcxGridDBColumn;
    imgLista: TImageList;
    shpMarcado: TShape;
    Label1: TLabel;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    Label2: TLabel;
    btnMarcarEmailNfe: TBitBtnLocked;
    btnMarcarEmail1: TBitBtnLocked;
    btnMarcarEmail2: TBitBtnLocked;
    lblTotalClientesSelecionados: TLabel;
    procedure cxgEmailsTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgEmailsTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgEmailsTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarEmailNfeClick(Sender: TObject);
    procedure btnMarcarEmail1Click(Sender: TObject);
    procedure btnMarcarEmail2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FTipoMarcacao              : TTipoMarcacao;
    FDados                     : TZClient;
    lstEmails                  : TStringList;
    FblnIgnorarEmailsInvalidos : Boolean;

    function fCarregaEmails(cxProgressBar: TCxProgressBar): Boolean;
    procedure pMarcarDesmarcar;
    procedure pInverte(strCampo: String);

    procedure pTotalizarEmailsSelecionados;

  public
    Class Function fSeleciona(cdsDados : TZClient; blnIgnorarEmailsInvalidos: Boolean = False) : String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando;

procedure TfrmEmailMarketingSelecao.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  FTipoMarcacao := tmDesmarcarTodos;
  pMarcarDesmarcar;
end;

procedure TfrmEmailMarketingSelecao.btnMarcarEmail1Click(Sender: TObject);
begin
  inherited;
  FTipoMarcacao := tmMarcarEmail1;
  pMarcarDesmarcar;
end;

procedure TfrmEmailMarketingSelecao.btnMarcarEmail2Click(Sender: TObject);
begin
  inherited;
  FTipoMarcacao := tmMarcarEmail2;
  pMarcarDesmarcar;
end;

procedure TfrmEmailMarketingSelecao.btnMarcarEmailNfeClick(Sender: TObject);
begin
  inherited;
  FTipoMarcacao := tmMarcarEmailNFe;
  pMarcarDesmarcar;
end;

procedure TfrmEmailMarketingSelecao.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  FTipoMarcacao := tmMarcarTodos;
  pMarcarDesmarcar;
end;

procedure TfrmEmailMarketingSelecao.cxgEmailsTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pInverte(TcxGridItemDBDataBinding(cxgEmailsTableView.Controller.FocusedColumn.DataBinding).FieldName);
end;

procedure TfrmEmailMarketingSelecao.cxgEmailsTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    APainter: TcxPainterAccess;
    strEmail_,
    strEmail2,
    strEmail3 : String;
    intIndex  : Integer;
begin
  inherited;
  If not (AViewInfo.EditViewInfo is TcxCustomTextEditViewInfo) Then
    Exit;

  If AViewInfo.GridRecord.Index < 0 Then
    Exit;

  If AViewInfo.Item.Index = cxgEmailsMARCA.Index Then
  Begin

    strEmail_ := '';
    strEmail2 := '';
    strEmail3 := '';

    If cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail.Index] <> Null Then
      strEmail_ := VarAsType( cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail.Index] , varString );

    If cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail2.Index] <> Null Then
      strEmail2 := VarAsType( cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail2.Index], varString );

    If cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail3.Index] <> Null Then
      strEmail3 := VarAsType( cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail3.Index], varString );

    intIndex := 0;
    If (lstEmails.IndexOf(strEmail_) >= 0) Or
       (lstEmails.IndexOf(strEmail2) >= 0) Or
       (lstEmails.IndexOf(strEmail3) >= 0) Then
      intIndex := 1;

    APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
    With APainter do
    Begin
      Try
        DrawBorders;
        With AViewInfo.ClientBounds Do
          imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, intIndex);
      Finally
        Free;
      End;
    End;
    ADone := True;

  End

  Else
  If AViewInfo.Item.Index = cxgEmailsEmail.Index Then
  Begin
    strEmail_ := '';
    If cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail.Index] <> Null Then
      strEmail_ := VarAsType( cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail.Index] , varString );
    If (lstEmails.IndexOf(strEmail_) < 0) Then
    Begin
      ACanvas.Font.Color := clRed;
      ACanvas.Font.Style := [fsBold];
    End
    Else
    Begin
      ACanvas.Font.Color := clBlack;
      ACanvas.Font.Style := [];
    End;
  End

  Else
  If AViewInfo.Item.Index = cxgEmailsEmail2.Index Then
  Begin
    strEmail_ := '';
    If cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail2.Index] <> Null Then
      strEmail_ := VarAsType( cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail2.Index] , varString );
    If (lstEmails.IndexOf(strEmail_) < 0) Then
    Begin
      ACanvas.Font.Color := clRed;
      ACanvas.Font.Style := [fsBold];
    End
    Else
    Begin
      ACanvas.Font.Color := clBlack;
      ACanvas.Font.Style := [];
    End;
  End

  Else
  If AViewInfo.Item.Index = cxgEmailsEmail3.Index Then
  Begin
    strEmail_ := '';
    If cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail3.Index] <> Null Then
      strEmail_ := VarAsType( cxgEmailsTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[cxgEmailsEmail3.Index] , varString );
    If (lstEmails.IndexOf(strEmail_) < 0) Then
    Begin
      ACanvas.Font.Color := clRed;
      ACanvas.Font.Style := [fsBold];
    End
    Else
    Begin
      ACanvas.Font.Color := clBlack;
      ACanvas.Font.Style := [];
    End;
  End

end;

procedure TfrmEmailMarketingSelecao.cxgEmailsTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = []) And ((Key = VK_SPACE) Or (Key = VK_RETURN)) Then
    pInverte(TcxGridItemDBDataBinding(cxgEmailsTableView.Controller.FocusedColumn.DataBinding).FieldName);
end;

class function TfrmEmailMarketingSelecao.fSeleciona(cdsDados: TZClient; blnIgnorarEmailsInvalidos: Boolean = False): String;
  Var
    frmForm : TfrmEmailMarketingSelecao;
begin
  Try
    pCriarFormularios(TfrmEmailMarketingSelecao, frmForm);

    frmForm.FDados    := cdsDados;
    frmForm.lstEmails := TStringList.Create;
    frmForm.cxgEmailsTableView.DataController.DataSource := frmForm.FDados.dtsSource;
    frmForm.FblnIgnorarEmailsInvalidos := blnIgnorarEmailsInvalidos;
    frmForm.btnMarcarTodos.Click;

    If frmForm.ShowModal = MrOK Then
      Result := fCommaText(frmForm.lstEmails, False, '; ');


  Finally
    FreeAndNil(frmForm.lstEmails);
    FreeAndNil(frmForm);
  End;

end;

procedure TfrmEmailMarketingSelecao.pMarcarDesmarcar;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaEmails;
    frmGravando.lblGravando.Caption := 'Aguarde, Sintetizando E-mails...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
End;

procedure TfrmEmailMarketingSelecao.pTotalizarEmailsSelecionados;
begin
  lblTotalClientesSelecionados.Caption := '  '
                                        + lstEmails.Count.ToString
                                        + ' E-mail(s) Selecionado(s)';
  lblTotalClientesSelecionados.Visible := lstEmails.Count > 0;
end;

Function TfrmEmailMarketingSelecao.fCarregaEmails(cxProgressBar : TCxProgressBar) : Boolean;
  Var
    intQtdPas     : Integer;
    blnPodeMarcar : Boolean;
Begin
  With FDados Do
  Begin
    Try
      intQtdPas := 0;
      cxProgressBar.pSetMax(RecordCount);

      DisableControls;
      First;
      While Not Eof Do
      Begin
        If FTipoMarcacao in [tmMarcarTodos, tmMarcarEmail1, tmMarcarEmail2, tmMarcarEmailNFe] Then
        Begin
          blnPodeMarcar := False;

          If FblnIgnorarEmailsInvalidos Then
          Begin
            If (Not fEmailInvalido(FieldByName('EMAIL_').AsString)) And
               (FTipoMarcacao in [tmMarcarTodos, tmMarcarEmail1]) Then
            Begin
              lstEmails.Add(FieldByName('EMAIL_').AsString);
              blnPodeMarcar := True;
            End;

            If (Not fEmailInvalido(FieldByName('EMAIL2').AsString)) And
               (FTipoMarcacao in [tmMarcarTodos, tmMarcarEmail2]) Then
            Begin
              lstEmails.Add(FieldByName('EMAIL2').AsString);
              blnPodeMarcar := True;
            End;

            If (Not fEmailInvalido(FieldByName('EMAIL3').AsString)) And
               (FTipoMarcacao in [tmMarcarTodos, tmMarcarEmailNFe]) Then
            Begin
              lstEmails.Add(FieldByName('EMAIL3').AsString);
              blnPodeMarcar := True;
            End;
          End
          Else
          Begin
            If (lstEmails.IndexOf(FieldByName('EMAIL_').AsString) < 0) And
               (not fEmptyStr(FieldByName('EMAIL_').AsString)) And
               (FTipoMarcacao in [tmMarcarTodos, tmMarcarEmail1]) Then
            Begin
              lstEmails.Add(FieldByName('EMAIL_').AsString);
              blnPodeMarcar := True;
            End;

            If (lstEmails.IndexOf(FieldByName('EMAIL2').AsString) < 0) And
               (not fEmptyStr(FieldByName('EMAIL2').AsString)) And
               (FTipoMarcacao in [tmMarcarTodos, tmMarcarEmail2]) Then
            Begin
              lstEmails.Add(FieldByName('EMAIL2').AsString);
              blnPodeMarcar := True;
            End;

            If (lstEmails.IndexOf(FieldByName('EMAIL3').AsString) < 0) And
               (not fEmptyStr(FieldByName('EMAIL3').AsString)) And
               (FTipoMarcacao in [tmMarcarTodos, tmMarcarEmailNFe]) Then
            Begin
              lstEmails.Add(FieldByName('EMAIL3').AsString);
              blnPodeMarcar := True;
            End;
          End;

          If blnPodeMarcar Then
          Begin
            Edit;
            FieldByName('MARCA').AsString := 'S';
            Post;
          End;
        End
        Else If FTipoMarcacao = tmDesmarcarTodos Then
        Begin
          If lstEmails.IndexOf(FieldByName('EMAIL_').AsString) >= 0 Then
            lstEmails.Delete(lstEmails.IndexOf(FieldByName('EMAIL_').AsString));

          If lstEmails.IndexOf(FieldByName('EMAIL2').AsString) >= 0 Then
            lstEmails.Delete(lstEmails.IndexOf(FieldByName('EMAIL2').AsString));

          If lstEmails.IndexOf(FieldByName('EMAIL3').AsString) >= 0 Then
            lstEmails.Delete(lstEmails.IndexOf(FieldByName('EMAIL3').AsString));

          Edit;
          FieldByName('MARCA').AsString := 'N';
          Post;
        End;
        Next;

        Inc(intQtdPas);
        cxProgressBar.pStepBy;

        If intQtdPas = 20 Then
        Begin
          Application.ProcessMessages;
          intQtdPas := 0;
        End;

      End;

      pTotalizarEmailsSelecionados;
      Result := True;
    Finally
      First;
      EnableControls;
    End;
  End;

End;

procedure TfrmEmailMarketingSelecao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Shift = [] Then
    Case Key Of
      VK_F2  : btnMarcarEmailNfe.Click;
      VK_F3  : btnMarcarEmail1.Click;
      VK_F4  : btnMarcarEmail2.Click;
      VK_F7  : btnMarcarTodos.Click;
      VK_F8  : btnDesmarcarTodos.Click;
      VK_F10 : btnConfirma.Click;
    End;

end;

procedure TfrmEmailMarketingSelecao.FormShow(Sender: TObject);
begin
  inherited;
  lblTotalClientesSelecionados.Visible := False;
end;

procedure TfrmEmailMarketingSelecao.pInverte(strCampo : String);
  Var
    intIndex : Integer;
Begin
  If fEmptyStr(FDados.FieldByName(strCampo).AsString) Then
    Exit;

  intIndex := lstEmails.IndexOf(FDados.FieldByName(strCampo).AsString);

  If intIndex >= 0 Then
    lstEmails.Delete(intIndex)
  Else
  Begin
    If FblnIgnorarEmailsInvalidos Then
    Begin
      If fEmailInvalido(FDados.FieldByName(strCampo).AsString) Then
        fMensagem('AVISO', 'E-mail inválido.', ['O& K'])
      Else
        lstEmails.Add(FDados.FieldByName(strCampo).AsString);
    End
    Else
      lstEmails.Add(FDados.FieldByName(strCampo).AsString);
  End;

  FDados.Edit;

  If (lstEmails.IndexOf(FDados.FieldByName('EMAIL_').AsString) >= 0) Or
     (lstEmails.IndexOf(FDados.FieldByName('EMAIL2').AsString) >= 0) Or
     (lstEmails.IndexOf(FDados.FieldByName('EMAIL3').AsString) >= 0) Then
    FDados.FieldByName('MARCA').AsString := 'S'
  Else
    FDados.FieldByName('MARCA').AsString := 'N';

  FDados.Post;

  pTotalizarEmailsSelecionados;
  cxgEmailsTableView.Site.Repaint;
End;

end.
