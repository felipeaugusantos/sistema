unit untCadEmbVelutex;

interface

uses
  Classes, Controls, Forms,
  untPaiCad, StdCtrls, ExtCtrls, Uni, 
  DB, Mask, DBCtrls, DBEditFocus, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmbVelutex = class(TfrmPaiCad)
    pnlCampos: TPanel;
    lblEmbalagem: TLabel;
    dbeEmbalagem: TDBEditFocus;
    lblProduto: TLabel;
    dbeProduto: TDBEditFocus;
    lblMultiplicador: TLabel;
    dbeMultiplicador: TDBEditFocus;
    lblUnidade: TLabel;
    edtUniDescri: TEditFocus;
    edtUniUni: TEditFocus;
    dbeCodUni: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodUniExit(Sender: TObject);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    qryCadEmb: TUniQuery;
    dtsCadEmb: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmCadEmbVelutex: TfrmCadEmbVelutex;

implementation

uses
  untCadUniLocalizador, untFuncoesSimples, untCadUniLocalizavel, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEmbVelutex.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  pSetFocus(dbeEmbalagem);
end;

procedure TfrmCadEmbVelutex.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
//  If fPesqEmbalagemUnidadeTinta(Self, conVel, Nil, Nil, Nil, '', qryTabela, Key, arrSel) Then
  If fPesqEmbalagens(Self, 'VEL_EMBALA', Nil, Nil, Nil, qryTabela, Key, arrSel) Then
    dbeCodUni.OnExit(Sender);
end;

constructor TfrmCadEmbVelutex.Create(AOwner: TComponent);
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
  inherited;
end;

destructor TfrmCadEmbVelutex.Destroy;
begin

  inherited;
end;

procedure TfrmCadEmbVelutex.dbeCodUniExit(Sender: TObject);
var
  strDescri: string;
  strUnid: string;
begin
  pRetDescUnidade(dbeCodUni.Text, strDescri, strUnid);
  edtUniDescri.Text := strDescri;
  edtUniUni.Text := strUnid;
end;

procedure TfrmCadEmbVelutex.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
var arrSel: TConsultasArray;
begin
  fPesqUnidade(Self, TEditFocus(dbeCodUni), edtUniDescri, edtUniUni, nil, key, arrSel);
end;

procedure TfrmCadEmbVelutex.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnPesquisa);
end;

procedure TfrmCadEmbVelutex.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadEmb;
  strNomeTabela := 'VEL_EMBALA';
  strNomeCampo := 'EMB_TAMEMB';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeEmbalagem;
  arrCamposChave[1] := dbeProduto;
end;

function TfrmCadEmbVelutex.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeEmbalagem) then
    begin
      if fStrToFloat(dbeEmbalagem.Text) <= 0 then
      begin
        fMensagem('ATEN플O!', 'A embalagem deve ser maior que zero!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeProduto) then
    begin
      if fEmptyStr(dbeProduto.Text) then
      begin
        fMensagem('ATEN플O!', 'O produto deve ser preenchido!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeMultiplicador) then
    begin
      if fStrToFloat(dbeMultiplicador.Text) <= 0 then
      begin
        fMensagem('ATEN플O!', 'O multiplicador deve ser maior que zero!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeCodUni) then
    begin
      if fEmptyStr(dbeCodUni.Text) then
      begin
        fMensagem('ATEN플O!', 'A unidade deve ser preenchida!', ['OK']);
        Result := False;
      end;
    end;
          
    
  end;  

  if not Result then
    pSetFocus(Sender);


end;

procedure TfrmCadEmbVelutex.pCriaDataSets;
begin
  qryCadEmb := fCriarQuery('SELECT * FROM VEL_EMBALA', Self);

  qryCadEmb.FieldByName('EMB_TAMEMB').DisplayLabel := 'Embalagem';
  qryCadEmb.FieldbyName('EMB_PRODUT').DisplayLabel := 'Produto';
  qryCadEmb.FieldbyName('EMB_CODUNI').DisplayLabel := 'Unidade';
  qryCadEmb.FieldbyName('EMB_MULTPL').DisplayLabel := 'Multiplicador';

  qryCadEmb.FieldByName('AUTOINCREM').Visible := False;

  dtsCadEmb := fCriaDataSource(qryCadEmb);
end;

procedure TfrmCadEmbVelutex.pInicializaIndices;
begin
  inherited;
  stlCampos.Clear;
  stlCampos.Add('EMB_TAMEMB');
  stlCampos.Add('EMB_PRODUT');
  stlCampos.Add('EMB_CODUNI');
  stlCampos.Add('EMB_MULTPL');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Clear;
  stlCamInd.Add('EMB_TAMEMB+EMB_PRODUT');
  stlCamInd.Add('EMB_CODUNI');

  stlDesInd.Clear;
  stlDesInd.Add('Embalagem/Produto');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadEmbVelutex.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadEmb;
    End;
  End;
end;

end.
