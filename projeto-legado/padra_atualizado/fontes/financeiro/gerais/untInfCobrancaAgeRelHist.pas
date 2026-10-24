unit untInfCobrancaAgeRelHist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, MaskEditFocus, Menus, Buttons, ExtCtrls,
  QColorLabel, EditFocus, Uni, AppEvnts, UniClientDataSet, BitBtnLockedIncrem,
  MemoFocus, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untConsultas;

type
  TfrmInfCobrancaAgeRelHist = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    mskHorAtu: TMaskEditFocus;
    Panel1: TPanel;
    pnlHistorico: TPanel;
    edtAgeRel: TEditFocus;
    lblData: TLabel;
    lblLegenda: TColorLabel;
    btnConfirmar: TBitBtnLocked;
    mmoHisCob: TMemoFocus;
    Label4: TLabel;
    mmoDup: TMemoFocus;
    mskDtaAtu: TcxDateEdit;
    mskAgeRel: TcxDateEdit;
    lblCanalAcesso: TLabel;
    edtDesCadCac: TEditFocus;
    edtCodCac: TEditFocus;

    procedure pBaixaTemporaria;

    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtAgeRelExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pCarregaDuplicatasSelecionadas;
    procedure pGravar;
    procedure pCarregaCanalAcesso;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    cdsInfCob: TUniClientDataSet;
    cdsDuplicatas: TUniClientDataSet;   // traz as duplicatas de todos os clientes do filtro;
    strCodCli: String;
    strCodEmp: String;
    blnRetorno: Boolean;
    blnBaixarReagendar : Boolean;
    blnVeioMostraDebCtrChq2 : Boolean;
    blnApagarInfoClient: Boolean;
    blnAgendamento : Boolean;
  end;


implementation

uses untfuncoesSimples, DB, untCadCob, untTypesSistema, untGravando;

{$R *.dfm}

procedure TfrmInfCobrancaAgeRelHist.FormCreate(Sender: TObject);
begin
  inherited;
  blnRetorno          := False;
  blnBaixarReagendar  := False;
  mskDtaAtu.Text      := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskHorAtu.Text      := FormatDateTime('hh:mm:ss', fTime());
  cdsDuplicatas       := TUniClientDataSet.Create(Nil);
  blnApagarInfoClient := True;
  pSetFocus(edtAgeRel);
end;

procedure TfrmInfCobrancaAgeRelHist.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  {OPÇÃO INSERIDA POIS NO LAYOUT NOVO, A TELA NÃO ERA FECHADA COM O ESC,
   MESMO COM O TRATAMENTO NO PAI, QUANDO ACTIVECONTROL = '' - KM}
  If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End;
  End;
end;

procedure TfrmInfCobrancaAgeRelHist.FormShow(Sender: TObject);
begin
  inherited;
  If blnAgendamento Then
  Begin
     lblLegenda.visible := False;
     edtagerel.visible  := False;
     edtagerel.text     := 'A';
     lblData.left        := 24;
     mskAgeRel.left     := 65;
     Caption := 'Agendamento - Histórico';

     edtCodCac.visible := False;
     edtDesCadCac.visible := False;
     lblCanalAcesso.visible := False;

  End
  Else
  Begin
    lblLegenda.width := 235;
    lblLegenda.Caption := '(A)gendamento (R)eligação (B)aixado';

    If blnBaixarReagendar then
       lblLegenda.Caption := '(R)eligação (B)aixado';

    If blnVeioMostraDebCtrChq2 Then
    Begin
       Self.Width := 615;
       mmoDup.ScrollBars := ssVertical;
       pCarregaDuplicatasSelecionadas;
    End;

  End;

end;

function TfrmInfCobrancaAgeRelHist.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(SeNder, blnBuscaPorChave)) Then
  Begin

    {****************************************}
    {* VALIDA O CAMPO AGENDAMENTO,RELIGACAO *}
    {* OU BAIXADOS                          *}
    {*************************************LB*}
    If (Sender = edtAgeRel) Then
    Begin

      If fEmptyStr(edtAgeRel.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo de Agendamento ou Religação deve ser preenchido!',['&OK']);
        Result := False;
      End
      Else
      If blnBaixarReagendar And (edtAgeRel.Text <> 'R') And (edtAgeRel.Text <> 'B') Then
      Begin
        fMensagem('ATENÇÃO','O campo de Agendamento ou Religação deve conter somente R ou B!',['&OK']);
        Result := False;
      End
      Else
      If (edtAgeRel.Text <> 'A') And (edtAgeRel.Text <> 'R') And (edtAgeRel.Text <> 'B')  Then
      Begin
        fMensagem('ATENÇÃO','O campo de Agendamento ou Religação deve conter somente R ou B!',['&OK']);
        Result := False;
      End;
    End

    Else
    {*********************************************}
    {* VALIDA A DATA DO AGENDAMENTO OU RELIGACAO *}
    {******************************************LB*}
    If (Sender = mskAgeRel) Then
    Begin

      If (edtAgeRel.Text <> 'B') Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskAgeRel.Text)) Then
        Begin
          fMensagem('ATENÇÃO','A Data para o Agendamento ou Religação deve ser preenchido!',['&OK']);
          Result := False;
        End
        Else
        Begin
          If Not fValidaPeriodo(DateToStr(VS_Date),mskAgeRel.Text) Then
          Begin
            fMensagem('ATENÇÃO','A Data para o Agendamento ou Religação deve ser maior que a data atual!',['&OK']);
            Result := False;
          End;
        End;
      End;
    End

    Else
    {********************************}
    {* VALIDA CAMPO CANAL DE ACESSO *}
    {********************************}
    If (Sender = edtCodCac) And (edtCodCac.visible) Then
    Begin
      If Not fEmptyStr(edtCodCac.Text) Then
      Begin
        pCarregaCanalAcesso;
        If (fEmptyStr(edtDesCadCac.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Canal de Acesso não cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
      //Else
{      Begin
        if fCfgSis('CLOBCA', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'Canal de Acesso deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
        edtDesCadCac.Text := EmptyStr;
      End;}
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmInfCobrancaAgeRelHist.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    Exit;
  End
  Else
  Begin
    If TfrmGravando.fExecutarModal(pGravar,'Aguarde... Realizando Agendamento/Religação','') Then
    Begin
      Self.Close;
    End;
  End;
end;

procedure TfrmInfCobrancaAgeRelHist.edtAgeRelExit(Sender: TObject);
begin
  inherited;

  {***********************************}
  {* VERIFICA SE O CAMPO FOR BAIXADO *}
  {* CASO SIM DESABILITA O CAMPO DATA*}
  {********************************LB*}
  If (edtAgeRel.Text = 'B') Then
  Begin
    mskAgeRel.Clear;
    mskAgeRel.Enabled    := False;
    edtCodCac.Clear;
    edtDesCadCac.Clear;
    edtCodCac.enabled    := False;
    edtDesCadCac.enabled := False;
    pSetFocus(btnConfirmar);
  End
  Else
  Begin
    mskAgeRel.Enabled    := True;
    edtCodCac.enabled    := True;
    edtDesCadCac.enabled := True;
    pSetFocus(mskAgeRel);
  End;

end;

procedure TfrmInfCobrancaAgeRelHist.edtCodCacExit(Sender: TObject);
begin
  inherited;
  //pEdtCodSelectExit(edtTipCli, edtDescTipCli, arrTipCli, Nil, fRetDescTipoCli, 'do Tipo Cliente');
  if fValidaCampos(edtCodCac, True) then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmInfCobrancaAgeRelHist.edtCodCacKeyPress(Sender: TObject;
  var Key: Char);
  Var
      arrCanal : TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE CANAL DE ACESSO *}
  {*********************************DP*}
  If fPesqCanalAcesso(Self, edtCodCac, edtDesCadCac, Nil, Key, arrCanal) Then
  Begin
    if fValidaCampos(edtCodCac, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobrancaAgeRelHist.pBaixaTemporaria;
  Var
  strCodCli: String;
  strFilterAtual : String;
begin


  {***********************************}
  {* Auxiliar Criado Para Filter     *}
  {*REQ41724***********************LE*}
  strFilterAtual := CdsInfCob.Filter;

  strCodCli := cdsInfCob.FieldByName('CLI_CODCLI').AsString;

  With cdsInfCob Do
  Begin
    DisableControls;
    Filter := 'CLI_CODCLI = ' + QuotedStr(strCodCli);
    Filtered := True;
    First;

    While Not Eof do
    Begin
      Delete;
    End;

    Filtered := False;
    Filter := strFilterAtual;
    Filtered := True;
    EnableControls;
  End;
end;

procedure TfrmInfCobrancaAgeRelHist.pCarregaDuplicatasSelecionadas;
Var
  intContador  : Integer;
  intTamMat   : Integer;
  arrDuplicatas: TStringArray;
begin
  Try
    If Not cdsInfCob.IsEmpty Then
    Begin
      mmoDup.Lines.Clear;

      cdsInfCob.IndexFieldNames:= 'CTR_DTAVEN;CTR_CODEMP;CTR_ESPDOC;CTR_NUMDUP;CTR_PARCEL';
      cdsInfCob.First;
      pAddDados(arrDuplicatas, '|---------------------------------------------------------------------------------|');
      pAddDados(arrDuplicatas, '|                             DUPLICATAS SELECIONADAS                             | ');
      pAddDados(arrDuplicatas, '|---------------------------------------------------------------------------------|');
      pAddDados(arrDuplicatas, '|DUPLICATA              |DT.VENCTO   |   VR.ORIGINAL|      VR.JUROS|  VR.CORRIGIDO|');
      pAddDados(arrDuplicatas, '|---------------------------------------------------------------------------------|');
      With cdsInfCob Do
      Begin
        While Not Eof Do
        Begin
          pAddDados(arrDuplicatas, '| ' + fPadR(FieldByName('CTR_NUMDUP').AsString,12) +'-'+
                                      FieldByName('CTR_PARCEL').AsString + '-' +
                                      FieldByName('CTR_ESPDOC').AsString + '-' +
                                      FieldByName('CTR_CODEMP').AsString + ' | ' +
                                      FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDateTime) + ' | ' +
                                      fPadL(FloatToStrF(FieldByName('CTR_VALORI').AsFloat, ffNumber, 9, 2),12) + ' | ' +
                                      fPadL(FloatToStrF(FieldByName('CTR_VALJUR').AsFloat, ffNumber, 9, 2),12) + ' | ' +
                                      fPadL(FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2),12) + ' |');
          Next;
        End;
        pAddDados(arrDuplicatas, '|---------------------------------------------------------------------------------|');
        mmoDup.Font.Name:= 'Courier New';
        If blnAgendamento then
           mmoDup.Visible:= False
        Else
           mmoDup.Visible:= True;
        intTamMat := Length(arrDuplicatas);
        For intContador := 0 To intTamMat -1 Do
        Begin
          mmoDup.Lines.Add(arrDuplicatas[intContador]);
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmInfCobrancaAgeRelHist.pCarregaDuplicatasSelecionadas]');
    End;
  End;
end;

procedure TfrmInfCobrancaAgeRelHist.pGravar;
  Var
    dtaDtaAtu: TDateTime;
    tmrHorAtu: TDateTime;
    dtaDtaAge: TDateTime;
    dtaDtaRel: TDateTime;
    strBaixad: String;
    strAutInc: String;
    strMsg   : String;
    strCodCac: String;
begin
  inherited;
  Try
    strAutInc := '';
    dtaDtaAtu := StrToDateTime(mskDtaAtu.Text);
    tmrHorAtu := StrToDateTime(mskHorAtu.Text);
    strCodCac := '';

    If (edtAgeRel.Text = 'A') Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskAgeRel.Text)) Then
         dtaDtaAge := 0
      Else
         dtaDtaAge := StrToDateTime(mskAgeRel.Text)
    End
    Else
      dtaDtaAge := 0;

    If (edtAgeRel.Text = 'R') Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskAgeRel.Text)) Then
        dtaDtaRel := 0
      Else
        dtaDtaRel := StrToDateTime(mskAgeRel.Text)
    End
    Else
      dtaDtaRel := 0;

    If (Not fEmptyStr(edtCodCac.Text)) And (edtCodCac.visible) Then
    Begin
       strCodCac := edtCodCac.Text;
    End;

    If (edtAgeRel.Text = 'B') Then
    Begin
      strBaixad := 'S';
      strMsg := 'Os registros selecionados anteriormente serão baixados. Deseja continuar?';
    End
    Else
    Begin
      strMsg := 'Os registros selecionados anteriormente serão baixados e será gerado um novo. Deseja continuar?';
      strBaixad := 'N';
    End;

    If blnBaixarReagendar Then
      If fMensagem('',strMsg,['&Sim','&Não'])=2 Then
        Exit;

    If blnVeioMostraDebCtrChq2 then
       cdsDuplicatas := nil;


    With cdsInfCob Do
    Begin
      {*************************************}
      {* ABRE A TRANSACAO E GRAVA NO BANCO *}
      {**********************************LB*}
      fStartTransaction;

      blnRetorno := fGravaCadCob(strAutInc,
                                 strCodEmp,
                                 dtaDtaAtu,
                                 tmrHorAtu,
                                 dtaDtaAge,
                                 dtaDtaRel,
                                 strBaixad,
                                 strCodCli,
                                 mmoHisCob.Texto,
                                 cdsInfCob,
                                 blnVeioMostraDebCtrChq2,
                                 cdsDuplicatas,
                                 strCodCac);

      If (Not blnRetorno) Then
      Begin
        fRollBack;
        Exit;
      End
      Else
      Begin
        fCommit;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmInfCobrancaAgrRelHist.pGravar]');
    End;

  End;
end;

procedure TfrmInfCobrancaAgeRelHist.pCarregaCanalAcesso;
begin
  If Not fEmptyStr(edtCodCac.Text) Then
    edtDesCadCac.Text := fRetNomCanalAcesso(edtCodCac.Text)
  Else
    edtDesCadCac.Text := EmptyStr;
End;

end.

