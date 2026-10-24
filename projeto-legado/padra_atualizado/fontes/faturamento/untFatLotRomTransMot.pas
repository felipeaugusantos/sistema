{*****************************}
{* qryConTra -> CADTRA       *}
{* qryConReg -> CADREG       *}
{**************************JB*}

unit untFatLotRomTransMot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, Mask, MaskEditFocus, DB, BitBtnLockedIncrem, UniClientDataSet,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatLotRomTransMot = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlCentral: TPanel;
    lblTransp: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    lblMotorista: TLabel;
    edtCodMot: TEditFocus;
    edtNomMot: TEditFocus;
    mskPlaVei: TMaskEditFocus;
    Label1: TLabel;
    edtDesVei: TEditFocus;
    edtDesLot: TEditFocus;
    Label2: TLabel;
    pnlBoxLot: TPanel;
    Label3: TLabel;
    edtBoxLot: TEditFocus;
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
  private
    qryConTra: TUniQuery;

    procedure pCarregaCadTra;
    function fCarregaCadMot: Boolean;
    { Private declarations }
  protected
    qryCadReg: TUniQuery;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNomeTabela : String;
    strCodRom     : String;
    fltTotDoc     : Double;     
    cdsTmpDoc     : TUniClientDataSet;
  end;

var
  frmFatLotRomTransMot: TfrmFatLotRomTransMot;

implementation

uses untfuncoesSimples, untTypesSistema, untPesqAux, untFatRomRoteiro, untConsultas;

{$R *.dfm}

procedure TfrmFatLotRomTransMot.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;

begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatLotRomTransMot.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strSQL    := 'SELECT * FROM CADREG';
  qryCadReg := fCriarQuery(strSQL, Self);

  qryConTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE', Self);

  pnlBoxLot.Visible := fCfgSis('MULSEP', varBoolean) and fCfgSis('BOXLOT', varBoolean);
  if not pnlBoxLot.Visible then
    Self.Height := Self.Height - pnlBoxLot.Height;
end;

procedure TfrmFatLotRomTransMot.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot, True, True) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatLotRomTransMot.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodTra) And (fCfgSis('TIPROM') = '1') Then
  Begin

    If (fEmptyStr(edtCodTra.Text)) Then
    Begin
      edtNomTra.Clear;
    End
    Else
    Begin
      pCarregaCadTra;
      If qryConTra.FieldByName('TRA_CODTRA').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = edtCodMot) Then
  Begin

    If (fEmptyStr(edtCodMot.Text)) Then
    Begin
      edtNomMot.Clear;
    End
    Else
    Begin
      If (Not fCarregaCadMot) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista está inativo!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(edtNomMot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Motorista não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End

  Else If Sender = mskPlaVei Then
  Begin
    mskPlaVei.Text := fTiraCaracEspeciais(mskPlaVei.Text);
    edtDesVei.Text := fRetornaDescricaoVeic(fTiraCaracEspeciais(mskPlaVei.Text));

    If Not fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    Begin
      If fEmptyStr(edtDesVei.Text) Then
      Begin
        Result := False;
        fMensagem('','Nenhum veículo cadastrado com esta placa!',['&Ok']);
      End
    End;

  End

  Else If Sender = edtDesLot Then
  Begin
    If fEmptyStr(edtDesLot.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a descrição!', ['&OK']);
      Result := False;
    End;
  End

  Else If Sender = edtBoxLot Then
  Begin
    If pnlBoxLot.Visible and fEmptyStr(edtBoxLot.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o box!', ['&OK']);
      Result := False;
    End;
  End ;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatLotRomTransMot.pCarregaCadTra;
begin
  pPesquisaCadTra(qryConTra, qryConTra, edtCodTra.Text);
  With qryConTra Do
  Begin
    edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString;
  End;
end;

function TfrmFatLotRomTransMot.fCarregaCadMot: Boolean;
begin
  If Not fEmptyStr(edtCodMot.Text) Then
  Begin
    if (fRetStatusMotorista(edtCodMot.Text) = 'I') Then
    Begin
      edtNomMot.Clear;
      Result := False;
      Exit;
    End
    Else
      edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);
  End
  Else
    edtNomMot.Clear;

  Result := True;
end;

procedure TfrmFatLotRomTransMot.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatLotRomTransMot.FormShow(Sender: TObject);
begin
  inherited;
  fCarregaCadMot;
  pCarregaCadTra;
  fValidaCampos(mskPlaVei, True);
  pSetFocus(edtDesLot);
end;

procedure TfrmFatLotRomTransMot.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

procedure TfrmFatLotRomTransMot.mskPlaVeiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVeic: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE VEÍCULOS   *}
  {****************************RV*}
  If fPesqVeiculos(Self, mskPlaVei, edtDesVei, Nil, Key, arrVeic) Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

end.

