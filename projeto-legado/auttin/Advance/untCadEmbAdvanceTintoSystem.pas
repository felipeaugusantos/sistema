unit untCadEmbAdvanceTintoSystem;

interface

uses
  Classes, Controls, Forms, untPaiCad, StdCtrls, ExtCtrls, Uni,
  DB, Mask, DBCtrls, DBEditFocus, EditFocus, AppEvnts, Menus,
  ComCtrls, Buttons, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmbAdvanceTintoSystem = class(TfrmPaiCad)
    pnlCampos: TPanel;
    lblEmbalagem: TLabel;
    dbeCodEmb: TDBEditFocus;
    lblProduto: TLabel;
    dbeDescricao: TDBEditFocus;
    lblUnidade: TLabel;
    edtUniDescri: TEditFocus;
    edtUniUni: TEditFocus;
    dbeCodUni: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodUniExit(Sender: TObject);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
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
  frmCadEmbAdvanceTintoSystem: TfrmCadEmbAdvanceTintoSystem;

implementation

uses
    untCadUniLocalizavel, untCadUniLocalizador, untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEmbAdvanceTintoSystem.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeCodUni.OnExit(Sender);
end;

procedure TfrmCadEmbAdvanceTintoSystem.btnExcluirClick(Sender: TObject);
begin
  inherited;
  edtUniDescri.Clear;
  edtUniUni.Clear;
end;

procedure TfrmCadEmbAdvanceTintoSystem.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  edtUniDescri.Clear;
  edtUniUni.Clear;
  pSetFocus(dbeCodEmb);
end;

procedure TfrmCadEmbAdvanceTintoSystem.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqEmbalagemUnidadeTinta(Self, conadt, Nil, Nil, Nil, '', qryTabela, key, arrSel) Then
    dbeCodUni.OnExit(Sender);
end;

constructor TfrmCadEmbAdvanceTintoSystem.Create(AOwner: TComponent);
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
  inherited;
end;

destructor TfrmCadEmbAdvanceTintoSystem.Destroy;
begin

  inherited;
end;

procedure TfrmCadEmbAdvanceTintoSystem.dbeCodUniExit(Sender: TObject);
var
  strDescri: string;
  strUnid: string;
begin
  pRetDescUnidade(dbeCodUni.Text, strDescri, strUnid);
  edtUniDescri.Text := strDescri;
  edtUniUni.Text := strUnid;
end;

procedure TfrmCadEmbAdvanceTintoSystem.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  fPesqUnidade(Self, dbeCodUni, edtUniDescri, edtUniUni, Nil, key, arrSel);
end;

procedure TfrmCadEmbAdvanceTintoSystem.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadEmb;
  strNomeTabela := 'ADT_CADEMB';
  strNomeCampo := 'EMB_CODEMB';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
end;

function TfrmCadEmbAdvanceTintoSystem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if (Sender = dbeCodEmb) then
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
      dbeCodUni.OnExit(dbeCodUni);
      if fEmptyStr(dbeCodUni.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['OK']);
        Result := False;
      end
      else if fEmptyStr(edtUniDescri.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade preenchida não é válida', ['OK']);
        Result := False;
      end;  
           
    end;
          
    
  end;  

  if not Result then
    pSetFocus(Sender);


end;

procedure TfrmCadEmbAdvanceTintoSystem.pCriaDataSets;
begin
  qryCadEmb := fCriarQuery('SELECT * FROM ADT_CADEMB', Self);

  qryCadEmb.FieldByName('EMB_CODEMB').DisplayLabel := 'Embalagem';
  qryCadEmb.FieldbyName('EMB_DESCRI').DisplayLabel := 'Descrição';
  qryCadEmb.FieldbyName('EMB_CODUNI').DisplayLabel := 'Unidade';

  qryCadEmb.FieldByName('AUTOINCREM').Visible := False;

  dtsCadEmb := fCriaDataSource(qryCadEmb);
end;

procedure TfrmCadEmbAdvanceTintoSystem.pInicializaIndices;
begin
  inherited;
  stlCampos.Clear;
  stlCampos.Add('EMB_CODEMB');
  stlCampos.Add('EMB_DESCRI');
  stlCampos.Add('EMB_CODUNI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Clear;
  stlCamInd.Add('EMB_DESCRI');
  stlCamInd.Add('EMB_CODUNI');

  stlDesInd.Clear;
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadEmbAdvanceTintoSystem.pLigaDataSets;
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
