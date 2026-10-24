unit untCtrLiberacaoFiltros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCtrLiberacaoFiltros = class(TfrmPai)
    pnlGeral: TPanel;
    rdgStatus: TRadioGroup;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    lblVendedor: TLabel;
    lblSenha: TLabel;
    edtSenha: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryCadOpe: TUniQuery;
    procedure pCarregaVendedor;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strTipLib: String;
  end;


implementation

uses untfuncoesSimples, untCtrLiberacaoPedidos, untConsultas, Data.DB, untTypesSistema;

{$R *.dfm}

procedure TfrmCtrLiberacaoFiltros.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin
    if fPesqOperador(Self, edtCodVen, edtNomVen, qryCadOpe, Key, arrSel) then
    Begin
      If (fValidaCampos(edtCodVen, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

function TfrmCtrLiberacaoFiltros.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodVen) Then
  Begin

    If (fEmptyStr(edtCodVen.Text)) Then
    Begin
      edtNomVen.Clear;
    End
    Else
    Begin
      pCarregaVendedor;
      If (qryCadOpe.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este vendedor não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtSenha) Then
  Begin

    If (fEmptyStr(edtCodVen.Text)) Then
    Begin

      If (Not fEmptyStr(fCfgSis('SENLIB'))) Then
      Begin
        If (edtSenha.Text <> fCfgSis('SENLIB')) Then
        Begin
          fMensagem('ATENÇÃO!', 'Senha não confere!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else 
    Begin
      If (qryCadOpe.IsEmpty) Then
        pCarregaVendedor;
        
      If (qryCadOpe.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este vendedor não está cadastrado!', ['&Ok']);
        Result := False;
      End 

      Else If (Not fSenhaPermitida(edtSenha.Text)) Or
              (qryCadOpe.FieldByName('OPE_SENOPE').AsString <> fCrypt(edtSenha.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Senha não confere!', ['&Ok']);
        Result := False;
      End;
    End;

  End;
end;

procedure TfrmCtrLiberacaoFiltros.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadOpe := fCriaQuery(Self);
end;

procedure TfrmCtrLiberacaoFiltros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryCadOpe.Close;
  FreeAndNil(qryCadOpe);
end;

procedure TfrmCtrLiberacaoFiltros.pCarregaVendedor;
begin
  With qryCadOpe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                 ');
    SQL.Add('  *                    ');
    SQL.Add('FROM                   ');
    SQL.Add('  CADOPE               ');
    SQL.Add('WHERE                  ');
    SQL.Add('  OPE_CODOPE = :CODOPE ');

    ParamByName('CODOPE').AsString := edtCodVen.Text;
    Open;

    edtNomVen.Text := FieldByName('OPE_NOMOPE').AsString;
  End;

end;

procedure TfrmCtrLiberacaoFiltros.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      pSetFocus(edtCodVen);
    End;
  End;
end;

procedure TfrmCtrLiberacaoFiltros.btnConfirmaClick(Sender: TObject);
var
  LfrmCtrLiberacaoPedidos: TfrmCtrLiberacaoPedidos;
begin
  inherited;
  If (Not fVerificaCampos) Then
  Begin
    Exit;
  End;

  Try
    try
      pCriarFormularios(TfrmCtrLiberacaoPedidos, LfrmCtrLiberacaoPedidos);
      Case rdgStatus.ItemIndex Of
        0: LfrmCtrLiberacaoPedidos.strStatus := 'N';
        1: LfrmCtrLiberacaoPedidos.strStatus := 'L';
        2: LfrmCtrLiberacaoPedidos.strStatus := 'T';
      End;
      LfrmCtrLiberacaoPedidos.strCodVen := edtCodVen.Text;
      LfrmCtrLiberacaoPedidos.strTipLib := strTipLib;

      LfrmCtrLiberacaoPedidos.ShowModal;
    finally
      pFreeAndNil(LfrmCtrLiberacaoPedidos);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCtrLiberacaoFiltros.btnConfirmaClick]');
    End;
  End;
end;

procedure TfrmCtrLiberacaoFiltros.FormShow(Sender: TObject);
  Var
    strCap: String;
begin
  inherited;
  {*************************}
  {* CAPTION DO FORMULÁRIO *}
  {**********************RV*}
  If (strTipLib = '1') And fCfgSis('LPPDBL', varBoolean) Then
    strCap := 'Liberação de Pedidos - Financeiro'
  Else If (strTipLib = '1') And Not fCfgSis('LPPDBL', varBoolean) Then
    strCap := 'Liberação de Pedidos'
  Else If (strTipLib = '2') Then
    strCap := 'Liberação de Pedidos - Comercial';
  Self.Caption := strCap;

  If (fCfgSis('TPVD12', varInteger) = 1) Then
    lblVendedor.Caption := 'Vendedor:'
  Else
    lblVendedor.Caption := 'Vendedor-2:';

  SelectNext(ActiveControl, True, True);
end;

end.

