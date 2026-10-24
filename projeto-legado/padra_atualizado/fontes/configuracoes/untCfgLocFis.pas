unit untCfgLocFis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, StrUtils, DBEditFocus,
  Vcl.Buttons, BitBtnLockedIncrem, MaskUtils, Vcl.Mask, untPaiConfirma, Vcl.ExtCtrls, Data.DB,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, untPai, System.Generics.Collections,
  EditFocus;

type
  TCfgLocFis = Class(TObject)
  Private
    strTipDad : String;
    intTamCam : Integer;
    blnComZer : Boolean;

    cmbTipDad: TComboBox;
    speTamCam: TSpinEdit;
    chkAutCom: TCheckBox;

    procedure pLoad(strLoad : String);
  Public
    strNomCam : String;

    Constructor Create(strNomCamC : String; cmbTipDadC: TComboBox; spnTamCamC: TSpinEdit; chkAutComC: TCheckBox; strLoad : String = '');

    procedure pSalva;
    procedure pCarrega;
    function fRetCfg : String;
    procedure pSetaConfiguracoes(dbeEdit : TDBEditFocus); Overload;
    procedure pSetaConfiguracoes(edtEdit : TEditFocus); Overload;

    procedure pOnExit1(DBEdit : TObject);
    procedure pOnExit2(DBEdit : TObject);
    procedure pOnExit3(DBEdit : TObject);
    procedure pOnExit4(DBEdit : TObject);

  End;

  TCamposCfgLocFis = Class(TObjectList<TCfgLocFis>)
  Public
    Constructor Create; Overload;
  End;

  TfrmCfgLocFis = class(TfrmPaiConfirma)
    lstCamDis: TListBox;
    lstCamCom: TListBox;
    btnAdicionar: TBitBtnLocked;
    btnRemover: TBitBtnLocked;
    Label3: TLabel;
    grbConfig: TGroupBox;
    spnTamCam: TSpinEdit;
    Label1: TLabel;
    cmbTipDad: TComboBox;
    Label2: TLabel;
    chkAutCom: TCheckBox;
    Label4: TLabel;
    procedure lstCamDisClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure lstCamComDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstCamComDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cmbTipDadChange(Sender: TObject);
    procedure grbConfigExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    intIndex : Integer;
  public
    strLocFis : String;
    function fGetConfiguracao : String;
  end;

  Const
    arrNomCam : Array of String = ['LOC_CODLSE', 'LOC_R_U_A_', 'LOC_PREDIO', 'LOC_ANDAR_', 'LOC_APARTA'];
    arrDesCam : Array of String = ['Local de Separação', 'Rua', 'Prédio', 'Andar', 'Apartamento'];

var
  frmCfgLocFis: TfrmCfgLocFis;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmCfgLocFis.btnAdicionarClick(Sender: TObject);
  Var
    objCfg : TCfgLocFis;
begin
  If lstCamCom.Items.IndexOf(lstCamDis.Items[lstCamDis.ItemIndex]) < 0 Then
  Begin
    objCfg := TCfgLocFis.Create( arrNomCam[ IndexText(lstCamDis.Items[lstCamDis.ItemIndex], arrDesCam) ]  , cmbTipDad, spnTamCam, chkAutCom);

    lstCamCom.Items.AddObject(lstCamDis.Items[lstCamDis.ItemIndex], objCfg );
    lstCamCom.ItemIndex:= lstCamCom.Items.Count -1;

    lstCamDis.Items.Delete(lstCamDis.ItemIndex);
    If lstCamDis.Items.Count > 0 Then
      lstCamDis.ItemIndex := 0;

    lstCamDisClick(nil);
  End;
end;

procedure TfrmCfgLocFis.btnRemoverClick(Sender: TObject);
  Var
    Obj : TObject;
begin
  If lstCamCom.ItemIndex >= 0 Then
  Begin
    lstCamDis.Items.Add(lstCamCom.Items[lstCamCom.ItemIndex]);
    lstCamDis.ItemIndex:= lstCamDis.Items.Count -1;

    Obj := lstCamCom.Items.Objects[lstCamCom.ItemIndex];
    FreeAndNil(Obj);
    lstCamCom.Items.Delete(lstCamCom.ItemIndex);

    If lstCamCom.Items.Count > 0 Then
      lstCamCom.ItemIndex := 0;

    lstCamDisClick(nil);
  End;
end;

procedure TfrmCfgLocFis.cmbTipDadChange(Sender: TObject);
begin
  chkAutCom.Enabled := cmbTipDad.ItemIndex = 1;
  If not chkAutCom.Enabled Then
    chkAutCom.Checked := False;
end;

function TfrmCfgLocFis.fGetConfiguracao: String;
  Var
    intIndex : Integer;
begin
  Result := '';

  For intIndex := 0 to lstCamCom.Items.Count -1 Do
    Result := Result + TCfgLocFis(lstCamCom.Items.Objects[intIndex]).fRetCfg;
end;

procedure TfrmCfgLocFis.FormCreate(Sender: TObject);
  Var
    strDescri : String;
begin
  intIndex := -1;
  lstCamDis.Items.Clear;

  For strDescri in arrDesCam Do
    lstCamDis.Items.Add(strDescri);

end;

procedure TfrmCfgLocFis.FormShow(Sender: TObject);
  Var
    strAux    : String;
    strDesCam : String;
    objCfg    : TCfgLocFis;
begin
  inherited;
  While not fEmptyStr(strLocFis) Do
  Begin
    strAux    := Copy(strLocFis, 1, 13);
    strLocFis := Copy(strLocFis, 14, Length(strLocFis));

    strDesCam :=  arrDesCam[IndexText(Copy(strAux,1,10), arrNomCam)];

    objCfg := TCfgLocFis.Create( arrNomCam[ IndexText(Copy(strAux,1,10), arrNomCam) ]  , cmbTipDad, spnTamCam, chkAutCom, strAux);

    lstCamCom.Items.AddObject(strDesCam, objCfg );
    lstCamDis.Items.Delete( lstCamDis.Items.IndexOf(strDesCam) );
  End;

end;

procedure TfrmCfgLocFis.grbConfigExit(Sender: TObject);
begin
  inherited;
  If lstCamCom.ItemIndex >= 0 Then
    TCfgLocFis(lstCamCom.Items.Objects[lstCamCom.ItemIndex]).pSalva;
end;

procedure TfrmCfgLocFis.lstCamComDragDrop(Sender, Source: TObject; X, Y: Integer);
  Var
    Point : TPoint;
begin
  Point.X := X;
  Point.Y := Y;

  If Sender = Source Then
  Begin
    lstCamCom.Items.Move(intIndex, lstCamCom.ItemAtPos( Point, True));
    intIndex := -1;
  End;
end;

procedure TfrmCfgLocFis.lstCamComDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
  Var
    Point : TPoint;
begin
  Accept := (Sender = Source);
  If (intIndex = -1) Then
  Begin
    Point.X := X;
    Point.Y := Y;
    intIndex := lstCamCom.ItemAtPos(Point, True);
  End;

end;

procedure TfrmCfgLocFis.lstCamDisClick(Sender: TObject);
begin
  btnAdicionar.Enabled := lstCamDis.Items.Count > 0;
  btnRemover.Enabled   := lstCamCom.Items.Count > 0;

  If lstCamCom.ItemIndex >= 0 Then
    TCfgLocFis(lstCamCom.Items.Objects[lstCamCom.ItemIndex]).pCarrega;

end;


{ TCfgLocFis }
constructor TCfgLocFis.Create(strNomCamC: String; cmbTipDadC: TComboBox; spnTamCamC: TSpinEdit; chkAutComC: TCheckBox; strLoad : String);
begin
  strNomCam := strNomCamC;
  strTipDad := 'A';
  intTamCam := 1;
  blnComZer := False;

  cmbTipDad := cmbTipDadC;
  speTamCam := spnTamCamC;
  chkAutCom := chkAutComC;

  If not fEmptyStr(strLoad) Then
    pLoad(strLoad);

end;

procedure TCfgLocFis.pLoad(strLoad: String);
begin
  strNomCam := Copy(strLoad,1,10);
  strTipDad := Copy(strLoad,11,1);
  intTamCam := StrToIntDef(Copy(strLoad,12,1),0);
  blnComZer := IIF(Copy(strLoad,13, 1) = 'S', True, False);
end;

function TCfgLocFis.fRetCfg: String;
begin
  Result := strNomCam + strTipDad + IntToStr(intTamCam) + IfThen(blnComZer,'S','N');
end;

procedure TCfgLocFis.pCarrega;
begin
  If strTipDad = 'L' Then
    cmbTipDad.ItemIndex := 0
  Else
  If strTipDad = 'A' Then
    cmbTipDad.ItemIndex := 1
  Else
  If strTipDad = '0' Then
    cmbTipDad.ItemIndex := 2;

  speTamCam.Value := intTamCam;
  chkAutCom.Checked := blnComZer;

  chkAutCom.Enabled := cmbTipDad.ItemIndex = 1;
  If not chkAutCom.Enabled Then
    chkAutCom.Checked := False;

end;

procedure TCfgLocFis.pSalva;
begin
  Case cmbTipDad.ItemIndex Of
    0 : strTipDad := 'L';
    1 : strTipDad := 'A';
    2 : strTipDad := '0';
  End;

  intTamCam := speTamCam.Value;
  blnComZer := chkAutCom.Checked;
end;

procedure TCfgLocFis.pSetaConfiguracoes(dbeEdit: TDBEditFocus);
begin
  If strTipDad = 'L' Then
    dbeEdit.TipoTexto := DBEditFocus.ttAlfabetico

  Else If strTipDad = 'A' Then
    dbeEdit.TipoTexto := DBEditFocus.ttNumerico

  Else If strTipDad = 'O' Then
    dbeEdit.TipoTexto := DBEditFocus.ttAlfanumerico;

  dbeEdit.MaxLength := intTamCam;
  //dbeEdit.CompZeros := blnComZer;
  If blnComZer Then
  Begin
    Case intTamCam Of
      1 : dbeEdit.OnExit := pOnExit1;
      2 : dbeEdit.OnExit := pOnExit2;
      3 : dbeEdit.OnExit := pOnExit3;
      4 : dbeEdit.OnExit := pOnExit4;
    End;

  End;
end;

procedure TCfgLocFis.pSetaConfiguracoes(edtEdit : TEditFocus);
begin
  If strTipDad = 'L' Then
    edtEdit.TipoTexto := EditFocus.ttAlfabetico

  Else If strTipDad = 'A' Then
    edtEdit.TipoTexto := EditFocus.ttNumerico

  Else If strTipDad = 'O' Then
    edtEdit.TipoTexto := EditFocus.ttAlfanumerico;

  edtEdit.MaxLength := intTamCam;
  edtEdit.TamCampo  := intTamCam;
  edtEdit.CompZeros := blnComZer;
end;

{ TCamposCfgLocFis }

constructor TCamposCfgLocFis.Create;
  Var
    strLocFis : String;
    strAux    : String;
begin
  inherited;
  strLocFis := fCfgSis('LOCFIS', varString);
  While not fEmptyStr(strLocFis) Do
  Begin
    strAux    := Copy(strLocFis, 1, 13);
    strLocFis := Copy(strLocFis, 14, Length(strLocFis));

    Self.Add(TCfgLocFis.Create( arrNomCam[ IndexText(Copy(strAux,1,10), arrNomCam) ], Nil, Nil, Nil, strAux));
  End;
end;

procedure TCfgLocFis.pOnExit1(DBEdit : TObject);
Begin
  If TDBEditFocus(DBEdit).DataSource.DataSet.State in DsEditModes Then
    TDBEditFocus(DBEdit).Field.AsString := fPadL(TDBEditFocus(DBEdit).Field.AsString, 1, '0');
End;

procedure TCfgLocFis.pOnExit2(DBEdit : TObject);
Begin
  If TDBEditFocus(DBEdit).DataSource.DataSet.State in DsEditModes Then
    TDBEditFocus(DBEdit).Field.AsString := fPadL(TDBEditFocus(DBEdit).Field.AsString, 2, '0');
End;

procedure TCfgLocFis.pOnExit3(DBEdit : TObject);
Begin
  If TDBEditFocus(DBEdit).DataSource.DataSet.State in DsEditModes Then
    TDBEditFocus(DBEdit).Field.AsString := fPadL(TDBEditFocus(DBEdit).Field.AsString, 3, '0');
End;

procedure TCfgLocFis.pOnExit4(DBEdit : TObject);
Begin
  If TDBEditFocus(DBEdit).DataSource.DataSet.State in DsEditModes Then
    TDBEditFocus(DBEdit).Field.AsString := fPadL(TDBEditFocus(DBEdit).Field.AsString, 4, '0');
End;

end.
