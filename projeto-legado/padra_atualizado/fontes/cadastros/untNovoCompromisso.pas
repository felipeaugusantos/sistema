unit untNovoCompromisso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, EditFocus, MemoFocus, BitBtnLockedIncrem, Spin, frxClass,
  frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmNovoCompromisso = class(TfrmPaiSimples)
    pnl1: TPanel;
    pnlBotoes1: TPanel;
    pnlTitulo: TPanel;
    btnGravar: TBitBtnLocked;
    btnCancel: TBitBtnLocked;
    pnlInf: TPanel;
    lblDescricao: TLabel;
    mmoDesCom: TMemoFocus;
    pnlReplica: TPanel;
    grpReplica: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    chkReplic: TCheckBox;
    edtDtaIni: TMaskEditFocus;
    edtDtaFin: TMaskEditFocus;
    chkDesSab: TCheckBox;
    chkDesDom: TCheckBox;
    edtPeriod: TSpinEdit;
    pnlSales: TPanel;
    lblCliente: TLabel;
    lblObserv: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    mmoObserv: TMemoFocus;
    rdgCatego: TRadioGroup;
    pnlSup: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblPreVis: TLabel;
    edtDtaCom: TMaskEditFocus;
    edtHorCom: TMaskEditFocus;
    edtTitCom: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure chkReplicClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    procedure pAjustaLayoutSales;
  public
    blnNovoCompromisso : Boolean;
    function fRetCategoria: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmNovoCompromisso: TfrmNovoCompromisso;

implementation

uses untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmNovoCompromisso.btnGravarClick(Sender: TObject);
begin
  if Not fVerificaCampos Then
    Exit;

  if fCfgSis('APPSAL', varBoolean) then
  begin
    if fEmptyStr(edtCodCli.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O Cliente deve ser preenchido!', ['&Ok']);
      pSetFocus(edtCodCli);
      Exit;
    end;

    if rdgCatego.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO!', 'A Categoria deve ser preenchida!', ['&Ok']);
      pSetFocus(rdgCatego);
      Exit;
    end;
  end;

  ModalResult := mrOk;
  inherited;
end;

procedure TfrmNovoCompromisso.chkReplicClick(Sender: TObject);
begin
  inherited;
  edtDtaIni.Text    := IIF(chkReplic.Checked, edtDtaCom.Text, EmptyStr);
  edtDtaFin.Enabled := False;  
  edtDtaFin.Enabled := chkReplic.Checked;
  edtPeriod.Enabled := chkReplic.Checked;
  chkDesSab.Enabled := chkReplic.Checked;
  chkDesDom.Enabled := chkReplic.Checked;        
end;

procedure TfrmNovoCompromisso.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  LClientes: TConsultasArray;
begin
  try
    if fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli,
      Nil, Key, LClientes) then
    begin
      if fValidaCampos(edtCodCli, True) then
        SelectNext(ActiveControl, True, True);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '');
  end;
end;

procedure TfrmNovoCompromisso.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDtaCom);
end;

procedure TfrmNovoCompromisso.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    If ((ActiveControl) Is TSpinEdit) Then
      SelectNext(ActiveControl, True, True);
  End
  Else
  If (Key = VK_F10) Then
  Begin
    Key := VK_NONAME;
    btnGravar.Click;
  End
  Else
    inherited;
end;

procedure TfrmNovoCompromisso.FormShow(Sender: TObject);
begin
  inherited;
  chkReplic.Checked := False;
  chkReplicClick(chkReplic);

  pAjustaLayoutSales;

  edtDtaCom.SelText;
  pSetFocus(edtDtaCom);
end;

function TfrmNovoCompromisso.fRetCategoria: String;
begin
  Result := '';

  case rdgCatego.ItemIndex of
    0: Result := 'V';
    1: Result := 'L';
    2: Result := 'E';
    3: Result := 'W';
    4: Result := 'O';
  end;
end;

function TfrmNovoCompromisso.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtDtaCom) Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciais(edtDtaCom.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data do Compromisso deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If (blnNovoCompromisso) And (StrToDate(edtDtaCom.Text) < VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe uma data maior que a data atual (' + DateToStr(VS_Date) + ')!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtHorCom) Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciais(edtHorCom.Text, True, False, False, True))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Hora do Compromisso deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If (blnNovoCompromisso) And (StrToDate(edtDtaCom.Text) = VS_Date) And (StrToTime(edtHorCom.Text) < fTime()) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe uma hora maior que a hora atual (' + TimeToStr(fTime()) + ')!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtTitCom) Then
      Begin
        If fEmptyStr(edtTitCom.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Título do Compromisso deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtPeriod) Then
      Begin
        If edtPeriod.Value <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A periodicidade da replicação deve ser maior que zero!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtDtaFin) Then
      Begin
        If chkReplic.Checked Then
        Begin      
          If (fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text))) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final da replicação deve ser preenchida!', ['&Ok']);
            Result := False;
          End
          Else If StrToDate(edtDtaFin.Text) < StrToDate(edtDtaIni.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'A data final da replicação não pode ser menor que a data inicial!', ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = edtCodCli) Then
      Begin
        If fCfgSis('APPSAL', varBoolean) Then
        Begin
          If Not fEmptyStr(edtCodCli.Text) Then
          Begin
            edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
            If fEmptyStr(edtNomCli.Text) Then
            Begin
              pMensagemOk('Nenhum cliente encontrado com este código!');
              Result := False;
            End;
          End
          else
          Begin
            fMensagem('ATENÇÃO!', 'O Cliente deve ser preenchido!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
  If Not (Result) Then
    pSetFocus(Sender);
end;

procedure TfrmNovoCompromisso.pAjustaLayoutSales;
var
  LAltura: Integer;
begin
  LAltura := 0;

  if not fCfgSis('APPSAL', varBoolean) then
  begin
    LAltura := pnlSales.Height;
    pnlSales.Visible := False;
  end;

  if not blnNovoCompromisso then
  begin
    LAltura := LAltura + pnlReplica.Height;
    pnlReplica.Visible := False;
  end;

  if LAltura > 0 then
    Height := Height - LAltura;
end;

end.

