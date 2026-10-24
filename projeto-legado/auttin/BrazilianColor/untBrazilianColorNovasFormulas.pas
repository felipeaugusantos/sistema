unit untBrazilianColorNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untGenericNovasFormulas, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, UniClientDataSet,
  AppEvnts, Menus, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  StdCtrls, Mask, DBCtrls, DBEditFocus, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus,
  Uni, DateUtils, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmBrazilianColorNovasFormulas = class(TfrmGenericNovasFormulas)
    lblDescricao: TLabel;
    dbeDescricao: TDBEditFocus;
    lblAno: TLabel;
    dbeAno: TDBEditFocus;
    lblMontadora: TLabel;
    dbeMontadora: TDBEditFocus;
    lblTipo: TLabel;
    dbeTipo: TDBEditFocus;
    edtDesMon: TEditFocus;
    Label1: TLabel;
    dbeAcrMob: TDBEditFocus;
    Label55: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label2: TLabel;
    Cmblinha: TComboBox;
    _dbeLinha: TDBEditFocus;
    procedure dbeMontadoraKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure CmblinhaChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarMontadora;
    procedure pTrataCampoLinha;
    function fRetIndiceLinha(strLinha : String) : Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure CarregarCampos; override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

var
  frmBrazilianColorNovasFormulas: TfrmBrazilianColorNovasFormulas;

implementation

uses
   untFuncoesSimples, untNovaFormulaBrazilianColor, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmBrazilianColorNovasFormulas }

procedure TfrmBrazilianColorNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pTrataCampoLinha;
end;

procedure TfrmBrazilianColorNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pTrataCampoLinha;
end;

procedure TfrmBrazilianColorNovasFormulas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pTrataCampoLinha;
end;

procedure TfrmBrazilianColorNovasFormulas.btnGravarClick(Sender: TObject);
begin
  if fEmptyStr(dbeTipo.Text) then
  begin
    fMensagem('ATENÇÃO', 'O tipo deve ser preenchido!', ['OK']);
    exit;
  end
  else
  if fEmptyStr(edtDesMon.Text) then
  begin
    if fEmptyStr(dbeMontadora.Text) then
    begin
      fMensagem('ATENÇÃO', 'A montadora deve ser preenchida!', ['OK']);
      exit;
    end
    else
    begin
      fMensagem('ATENÇÃO', 'A montadora não está cadastrada!', ['OK']);
      exit;
    end;
  end
  else
  if fEmptyStr(dbeAno.Text) then
  begin
    fMensagem('ATENÇÃO', 'O ano deve ser preenchido!', ['OK']);
    exit;
  end
  else
  if fEmptyStr(dbeDescricao.Text) then
  begin
    fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
    exit;
  end
  else
  If fEmptyStr(dbeAcrMob.Text) Then
  Begin
    dbeAcrMob.Field.AsFloat := 0.00;
  End
  Else
  If Not fEmptyStr(dbeAcrMob.Text) Then
  Begin
    If (fStrToFloat(dbeAcrMob.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']);
      exit;
    End;
  End;
  if (Cmblinha.ItemIndex = -1) then
  begin
    fMensagem('ATENÇÃO', 'A Linha deve ser preenchida!', ['OK']);
    exit;
  end;

  inherited;
  pTrataCampoLinha;
end;

procedure TfrmBrazilianColorNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeDtaCad.Field.AsDateTime := Date;
  pTrataCampoLinha;
end;

procedure TfrmBrazilianColorNovasFormulas.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  Cmblinha.ItemIndex := fRetIndiceLinha(_dbeLinha.Text)
end;

procedure TfrmBrazilianColorNovasFormulas.CarregarCampos;
begin
  CarregarMontadora;
end;

procedure TfrmBrazilianColorNovasFormulas.CarregarMontadora;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'SELECT MON_DESCRI FROM BZC_CADMON  WHERE MON_CODMON = :CODMON';
      qryGen.ParamByName('CODMON').AsString := dbeMontadora.Text;
      qryGen.Open;

      edtDesMon.Text := qryGen.FieldByName('MON_DESCRI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

procedure TfrmBrazilianColorNovasFormulas.CmblinhaChange(Sender: TObject);
begin
  inherited;
  _dbeLinha.Field.AsString := Cmblinha.Text;

end;

constructor TfrmBrazilianColorNovasFormulas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TNovaFormulaBrazilianColor.Create);
end;

procedure TfrmBrazilianColorNovasFormulas.dbeMontadoraKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqMontadoraTinta(Self, conBzc, TDBEdit(Sender), Nil, Nil, Key, arrSel) Then
  Begin
    CarregarMontadora;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmBrazilianColorNovasFormulas.fRetIndiceLinha(strLinha: String): Integer;
begin
  If strLinha = 'BASE POLIESTER' Then
    Result := 0
  else
  If strLinha = 'EPOXY' Then
    Result := 1
  else
  if strLinha = 'LACA NITRO' Then
    Result := 2
  else
  if strLinha = 'POLIURETANO' THen
    Result := 3
  else
  if strLinha = 'PU CLASSICO' Then
    Result := 4
  else
  if strLinha = 'SINTETICO' Then
    Result := 5
  else
    Result := -1;
end;

function TfrmBrazilianColorNovasFormulas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Not Result then
    pSetFocus(Sender);
end;

procedure TfrmBrazilianColorNovasFormulas.pTrataCampoLinha;
begin
  Cmblinha.Enabled   := _dbeLinha.Enabled;
  Cmblinha.ItemIndex := fRetIndiceLinha(_dbeLinha.Field.AsString);

end;

initialization
  RegisterClass(TfrmBrazilianColorNovasFormulas);
finalization
  UnRegisterClass(TfrmBrazilianColorNovasFormulas);

end.
