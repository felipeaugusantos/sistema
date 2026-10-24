unit untCadEmbInternational;

interface

uses
  Classes, Controls, Forms,
  untPaiCad, StdCtrls, ExtCtrls, Uni, 
  DB,  Mask, DBCtrls, DBEditFocus, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmbInternational = class(TfrmPaiCad)
    pnlCampos: TPanel;
    lblEmbalagem: TLabel;
    dbeCodEmb: TDBEditFocus;
    lblProduto: TLabel;
    dbeDescricao: TDBEditFocus;
    lblMultiplicador: TLabel;
    dbeTamanho: TDBEditFocus;
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
  frmCadEmbInternational: TfrmCadEmbInternational;

implementation

uses
  untCadUniLocalizador, untFuncoesSimples,
  untCadUniLocalizavel, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEmbInternational.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  pSetFocus(dbeDescricao);
end;

procedure TfrmCadEmbInternational.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqEmbalagemUnidadeTinta(Self, conInt, Nil, Nil, Nil, '', qryTabela, Key, arrSel) Then
    dbeCodUni.OnExit(Sender);
end;

constructor TfrmCadEmbInternational.Create(AOwner: TComponent);
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
  inherited;
end;

destructor TfrmCadEmbInternational.Destroy;
begin

  inherited;
end;

procedure TfrmCadEmbInternational.dbeCodUniExit(Sender: TObject);
var
  strDescri: string;
  strUnid: string;
begin
  pRetDescUnidade(dbeCodUni.Text, strDescri, strUnid);
  edtUniDescri.Text := strDescri;
  edtUniUni.Text := strUnid;
end;

procedure TfrmCadEmbInternational.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
    fPesqUnidade(Self, dbeCodUni, edtUniDescri, edtUniUni, Nil, Key, arrSel);
end;

procedure TfrmCadEmbInternational.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnPesquisa);
end;

procedure TfrmCadEmbInternational.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadEmb;
  strNomeTabela := 'INT_CADEMB';
  strNomeCampo := 'EMB_CODEMB';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
end;

function TfrmCadEmbInternational.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeTamanho) then
    begin
      if fStrToFloat(dbeTamanho.Text) <= 0 then
      begin
        fMensagem('ATENÇÃO!', 'O tamanho deve ser maior que zero!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeCodEmb) then
    begin
      if fEmptyStr(dbeCodEmb.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeDescricao) then
    begin
      if fEmptyStr(dbeDescricao.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeCodUni) then
    begin
      if fEmptyStr(dbeCodUni.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['OK']);
        Result := False;
      end;
    end;
          
    
  end;  

  if not Result then
    pSetFocus(Sender);


end;

procedure TfrmCadEmbInternational.pCriaDataSets;
begin
  qryCadEmb := fCriarQuery('SELECT * FROM INT_CADEMB', Self);

  qryCadEmb.FieldByName('EMB_CODEMB').DisplayLabel := 'Embalagem';
  qryCadEmb.FieldbyName('EMB_DESEMB').DisplayLabel := 'Descrição';
  qryCadEmb.FieldbyName('EMB_CODUNI').DisplayLabel := 'Unidade';
  qryCadEmb.FieldbyName('EMB_TAMEMB').DisplayLabel := 'Tamanho';

  qryCadEmb.FieldByName('AUTOINCREM').Visible := False;

  dtsCadEmb := fCriaDataSource(qryCadEmb);
end;

procedure TfrmCadEmbInternational.pInicializaIndices;
begin
  inherited;
  stlCampos.Clear;
  stlCampos.Add('EMB_CODEMB');
  stlCampos.Add('EMB_DESEMB');
  stlCampos.Add('EMB_CODUNI');
  stlCampos.Add('EMB_TAMEMB');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Clear;
  stlCamInd.Add('EMB_DESEMB');
  stlCamInd.Add('EMB_CODUNI');

  stlDesInd.Clear;
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadEmbInternational.pLigaDataSets;
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
