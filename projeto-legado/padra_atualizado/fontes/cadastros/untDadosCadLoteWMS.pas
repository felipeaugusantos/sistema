unit untDadosCadLoteWMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, MaskEditFocus, EditFocus, untTProcessaEtiqueta;

type
  TfrmDadosCadLoteWMS = class(TfrmPaiSimples)
    btnGravar: TBitBtnLocked;
    pnlPrinc: TPanel;
    lbl3: TLabel;
    lblLocFis: TLabel;
    lblLocSep: TLabel;
    Label1: TLabel;
    shpNumLot: TShape;
    mskDtaVal: TMaskEditFocus;
    edtLocFis: TEditFocus;
    edtLocSep: TEditFocus;
    chkAbsAut: TCheckBox;
    edtNumLot: TEditFocus;
    pnlCodIte: TPanel;
    lbl1: TLabel;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    pnlCodbar: TPanel;
    lblCodbar: TLabel;
    edtCodbar: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtLocSepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function fObrigaInformarLote(strCodIte: String): Boolean;
  protected
    objEtiqueta: TProcessaEtiqueta;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;

    blnCadLoc: Boolean;
    dbeNumLot: TDBEditFocus;
    dbeDtaVal: TDBEditFocus;
    dbeLocFis: TDBEditFocus;
    dbeLocSep: TDBEditFocus;
    dbeAbsAut: TDBCheckBox;
    dbeCodIte: TDBEditFocus;

    strCodIte: String;

    fValidarCamposLote: function(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean of object;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesConsulta;

procedure TfrmDadosCadLoteWMS.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmDadosCadLoteWMS.edtCodIteExit(Sender: TObject);
  Var
    arrProduto : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrProduto,Nil,fRetNomProduto,'do produto',fTamCodIte);
end;

procedure TfrmDadosCadLoteWMS.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(dbeCodIte, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDadosCadLoteWMS.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmDadosCadLoteWMS.edtLocSepKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLocSep : TConsultasArray;
begin
  If fPesqLocSep(Self, edtLocSep, Nil, Nil, Key, arrLocSep) Then
  Begin
    If fValidaCampos(edtLocSep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDadosCadLoteWMS.fObrigaInformarLote(strCodIte: String): Boolean;
begin
  Result := False;

  if fEmptyStr(strCodIte) then
    Exit;

  if not fCfgSis('OBRLOT', varBoolean) then
    Exit;

  if fCampoTabela('ITE_LOTRAP', 'CADITE', ['ITE_CODITE'], [strCodIte], False) <> 'S' then
    Exit;

  Result := True;
end;

procedure TfrmDadosCadLoteWMS.FormCreate(Sender: TObject);
begin
  inherited;
  strCodIte := '';
  If Not fVerificaAcessoSistema('WMSLOT') Then
  Begin
    shpNumLot.Brush.Color := clRed;
    edtNumLot.Enabled     := False;
  End
  Else
    shpNumLot.Brush.Color := clGreen;

  objEtiqueta := TProcessaEtiqueta.Create('FRMDADOSCADLOTEWMS', Self);

end;

procedure TfrmDadosCadLoteWMS.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objEtiqueta);
end;

procedure TfrmDadosCadLoteWMS.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma       := False;
  edtNumLot.Text    := dbeNumLot.Text;
  mskDtaVal.Text    := dbeDtaVal.Text;
  edtLocFis.Text    := dbeLocFis.Text;
  edtLocSep.Text    := dbeLocSep.Text;
  chkAbsAut.Checked := dbeAbsAut.Checked;
  blnCadLoc         := fCfgSis('CADLOC', varBoolean);

  pnlCodbar.Visible := fCfgSis('BARLOT', varBoolean);
  If Not pnlCodIte.Visible Then
    Self.Height := Self.Height - pnlCodIte.Height + IIf(pnlCodbar.Visible, pnlCodbar.Height, 0);

  SelectFirst;

  pSetaCodIte( edtCodIte );

end;

function TfrmDadosCadLoteWMS.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var strCodIteRes: string;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = mskDtaVal Then
    Begin
      If strToDateDef(mskDtaVal.Text, 0) = 0 Then
        dbeDtaVal.Field.Value := Null
      Else
        dbeDtaVal.Field.AsDateTime := strToDate(mskDtaVal.Text);

      If fEmptyStr(edtNumLot.Text) Then
        Result := fValidarCamposLote(dbeDtaVal, blnBuscaPorChave);

    End
    Else If (pnlCodbar.Visible) And (Sender = edtCodbar) Then
    Begin
      objEtiqueta.pLeEtiqueta(edtCodbar.Text);
      If Not fEmptyStr(objEtiqueta.Campo['CODBAR'].Valor) Then
      Begin
        If pnlCodIte.Visible Then
        Begin
          objEtiqueta.pPreencheCampos;
          pSetFocus(edtCodIte);
          edtCodIte.Text := fCodigoDeBarrasToCodIte(objEtiqueta.Campo['CODBAR'].Valor);
        End
        Else
        Begin
          strCodIteRes := fCodigoDeBarrasToCodIte(objEtiqueta.Campo['CODBAR'].Valor);
          If strCodIte <> strCodIteRes Then
            fMensagem('Atenção', 'A etiqueta informada não pertence ao item selecionado.', ['&Ok'])
          Else
            objEtiqueta.pPreencheCampos
        End;
      End;

    End

    Else If Sender = edtLocFis Then
    Begin
      dbeLocFis.Field.AsString := edtLocFis.Text;
      Result := fValidarCamposLote(dbeLocFis, blnBuscaPorChave);
    End
    Else If Sender = edtLocSep Then
    Begin
      dbeLocSep.Field.AsString := edtLocSep.Text;
      Result := fValidarCamposLote(dbeLocSep, blnBuscaPorChave);
    End
    Else If Sender = chkAbsAut Then
    Begin
      dbeAbsAut.Checked := chkAbsAut.Checked;
      Result := fValidarCamposLote(dbeAbsAut, blnBuscaPorChave);
    End
    Else If (Sender = edtNumLot) and edtNumLot.Enabled Then
    Begin
      If not fEmptyStr(edtNumLot.Text) Then
      Begin
        dbeNumLot.Field.AsString := edtNumLot.Text;
        Result := fValidarCamposLote(dbeNumLot, blnBuscaPorChave);
      End
      Else If fObrigaInformarLote(edtCodIte.Text) then
      Begin
        fMensagem('Atenção', 'É obrigatório informar o lote.', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodIte) And pnlCodIte.Visible Then
    Begin
      dbeCodIte.Field.AsString := edtCodIte.Text;
      Result := fValidarCamposLote(dbeCodIte, blnBuscaPorChave);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


end.
