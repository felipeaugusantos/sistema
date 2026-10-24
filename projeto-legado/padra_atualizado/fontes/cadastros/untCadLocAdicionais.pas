unit untCadLocAdicionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, EditFocus,
  untFuncoesSimples, untFuncoesConsulta, untConsultas, untTypesSistema,
  untLocFisAdicionais, cxDBLookupComboBox, untCadLote,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadLocAdicionais = class(TfrmPaiEdit)
    Panel1: TPanel;
    btnExcluir: TBitBtnLocked;
    cxvLocFis: TcxGridDBTableView;
    cxgLocFisLevel1: TcxGridLevel;
    cxgLocFis: TcxGrid;
    cxvLocFisLOCFIS: TcxGridDBColumn;
    cxvLocFisDESCRI: TcxGridDBColumn;
    Label5: TLabel;
    edtLocFis: TEditFocus;
    edtDescri: TEditFocus;
    Panel2: TPanel;
    shpLocFisAdi: TShape;
    procedure FormCreate(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    strTraLoc: String;
    blnCadLoc: Boolean;
    objCadLot: TCadLot;
    intLocFis,
    intLocSup,
    intTamLcf,
    intLocSep : Integer;
  public
    { Public declarations }
    objLocFis: TLocFisAdicionais;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmCadLocAdicionais: TfrmCadLocAdicionais;

implementation

{$R *.dfm}

procedure TfrmCadLocAdicionais.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If (Not objLocFis.IsEmpty) And
      fPergunta('Deseja excluir a Localização ' + objLocFis.FieldByName('LOC_LOCFIS').AsString) then
    objLocFis.Delete;
end;

procedure TfrmCadLocAdicionais.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If Not edtLocFis.ReadOnly And blnCadLoc And
    fPesqLocFisica(Self, edtLocFis, edtDescri, Nil, Key, arrSel) Then
      fValidaCampos(edtLocFis, True);
end;

procedure TfrmCadLocAdicionais.FormCreate(Sender: TObject);
begin
  inherited;

  strTraLoc          := fCfgSIs('TRALOC');
  blnCadLoc          := fCfgSis('CADLOC', varBoolean);
  blnFecharComEscape := False;

  edtDescri.Visible        := blnCadLoc;
  cxvLocFisDESCRI.Visible  := blnCadLoc;

  objCadLot := TCadLot.Create(Self);

  pTamanhoCamposLocFis(intLocFis, intLocSup, intTamLcf, intLocSep);

  With edtLocFis Do
  Begin
    TamCampo := intLocFis;
    MaxLength:= intLocFis;
  End;

end;

procedure TfrmCadLocAdicionais.FormShow(Sender: TObject);
begin
  inherited;

  cxvLocFis.DataController.DataSource := objLocFis.dtsSource;
end;

function TfrmCadLocAdicionais.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    strLote,
    strItem: String;
    fltSaldos,
    fltSal_ML: Double;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtLocFis) Then
    Begin

      If (Not fEmptyStr(edtLocFis.Text)) Then
      Begin

        If blnCadLoc Then
        Begin
          edtDescri.Text := fRetNomLocFisica(edtLocFis.Text);

          If fEmptyStr(edtDescri.Text) then
          Begin
            pMensagemOk('Localização Física não encontrada!');
            Result := False;
          End
        End;

        If (strTraLoc <> 'N') And (Result) Then
        Begin

          If objCadLot.fTemProdutoComLocFisica(edtLocFis.Text, strItem, fltSaldos, fltSal_ML, objLocFis.strIteAtu) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemProdutoComLocAdicional(edtLocFis.Text, strItem, fltSaldos, fltSal_ML, objLocFis.strIteAtu) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física adicional!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemLoteComLocFisica(edtLocFis.Text, strItem, strLote, fltSaldos, fltSal_ML) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' (' + objCadLot.strTitLab + strLote + ') já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End;

        End;

        If Result And blnValidaIndividual And objLocFis.fIncluiLocalizacao(edtLocFis.Text) Then
        Begin
          blnMudarFoco := False;
          edtLocFis.Clear;
          edtDescri.Clear;
        End;
      End;

    End

    Else blnMudarFoco := True;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
