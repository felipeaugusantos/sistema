unit untCadEmbSayerLack;

interface

uses
  Classes, Controls, Forms,
  untPaiCad, StdCtrls, ExtCtrls, Uni,
  DB,  Mask, DBCtrls, DBEditFocus, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmbSayerLack = class(TfrmPaiCad)
    pnlCampos: TPanel;
    lblEmbalagem: TLabel;
    dbeEmbalagem: TDBEditFocus;
    lblTamanho: TLabel;
    dbeTamanho: TDBEditFocus;
    lblUnidade: TLabel;
    edtUniDescri: TEditFocus;
    edtUniUni: TEditFocus;
    dbeCodUni: TDBEditFocus;
    pnlCabecalho: TPanel;
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
  frmCadEmbSayerLack: TfrmCadEmbSayerLack;

implementation

uses
  untCadUniLocalizador, untFuncoesSimples,
  untCadUniLocalizavel, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEmbSayerLack.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  pSetFocus(dbeEmbalagem);
end;

procedure TfrmCadEmbSayerLack.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqEmbalagemUnidadeTinta(Self, conSay, Nil, Nil, Nil, '', qryTabela, Key, arrSel) Then
  dbeCodUni.OnExit(Sender);
end;

constructor TfrmCadEmbSayerLack.Create(AOwner: TComponent);
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
  inherited;
end;

destructor TfrmCadEmbSayerLack.Destroy;
begin

  inherited;
end;

procedure TfrmCadEmbSayerLack.dbeCodUniExit(Sender: TObject);
var
  strDescri: string;
  strUnid: string;
begin
  pRetDescUnidade(dbeCodUni.Text, strDescri, strUnid);
  edtUniDescri.Text := strDescri;
  edtUniUni.Text := strUnid;
end;

procedure TfrmCadEmbSayerLack.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  fPesqUnidade(Self, dbeCodUni, edtUniDescri, edtuniUni, Nil, Key, arrSel);
end;

procedure TfrmCadEmbSayerLack.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnPesquisa);
end;

procedure TfrmCadEmbSayerLack.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadEmb;
  strNomeTabela := 'SAY_CADEMB';
  strNomeCampo := 'EMB_EMBALA';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeEmbalagem;
end;

function TfrmCadEmbSayerLack.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeEmbalagem) then
    begin
      if fEmptyStr(dbeEmbalagem.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A embalagem deve ser preenchida!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeTamanho) then
    begin
      if fStrToFloat(dbeTamanho.Text) <= 0 then
      begin
        fMensagem('ATENÇÃO!', 'O tamanho deve ser maior que zero!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeCodUni) then
    begin
      dbeCodUniExit(Sender);
      if fEmptyStr(dbeCodUni.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['OK']);
        Result := False;
      end
      else if fEmptyStr(edtUniDescri.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade preenchida não é válida!', ['OK']);
        Result := False;
      end;  
           
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadEmbSayerLack.pCriaDataSets;
begin
  qryCadEmb := fCriarQuery('SELECT * FROM SAY_CADEMB', Self);

  qryCadEmb.FieldByName('EMB_DESEMB').DisplayLabel := 'Embalagem';
  qryCadEmb.FieldbyName('EMB_CODUNI').DisplayLabel := 'Unidade';
  qryCadEmb.FieldbyName('EMB_EMBALA').DisplayLabel := 'Tamanho';

  qryCadEmb.FieldByName('AUTOINCREM').Visible := False;

  dtsCadEmb := fCriaDataSource(qryCadEmb);
end;

procedure TfrmCadEmbSayerLack.pInicializaIndices;
begin
  inherited;
  stlCampos.Clear;
  stlCampos.Add('EMB_DESEMB');
  stlCampos.Add('EMB_CODUNI');
  stlCampos.Add('EMB_EMBALA');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Clear;
  stlCamInd.Add('EMB_DESEMB+EMB_EMBALA');
  stlCamInd.Add('EMB_CODUNI');

  stlDesInd.Clear;
  stlDesInd.Add('Embalagem/Tamanho');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadEmbSayerLack.pLigaDataSets;
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
