unit untCadEmbAlessi;

interface

uses
  Classes, Controls, Forms,
  untPaiCad, StdCtrls, ExtCtrls, Uni, 
  DB, Mask, DBCtrls, DBEditFocus, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmbAlessi = class(TfrmPaiCad)
    pnlCampos: TPanel;
    lblEmbalagem: TLabel;
    dbeCodEmb: TDBEditFocus;
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
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
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
  frmCadEmbAlessi: TfrmCadEmbAlessi;

implementation

uses
   untCadUniLocalizavel,untCadUniLocalizador,
   untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEmbAlessi.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeCodUni.OnExit(Sender);
end;

procedure TfrmCadEmbAlessi.btnExcluirClick(Sender: TObject);
begin
  inherited;
  edtUniDescri.Clear;
  edtUniUni.Clear;

end;

procedure TfrmCadEmbAlessi.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  edtUniDescri.Clear;
  edtUniUni.Clear;

  pSetFocus(dbeCodEmb);
end;

procedure TfrmCadEmbAlessi.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  if fPesqEmbalagemUnidadeTinta(Self, conAle, nil, Nil, Nil, '', qryTabela, Key, arrSel) Then
    dbeCodUni.OnExit(Sender);
end;

constructor TfrmCadEmbAlessi.Create(AOwner: TComponent);
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
  inherited;
end;

destructor TfrmCadEmbAlessi.Destroy;
begin

  inherited;
end;

procedure TfrmCadEmbAlessi.dbeCodUniExit(Sender: TObject);
var
  strDescri: string;
  strUnid: string;
begin
  pRetDescUnidade(dbeCodUni.Text, strDescri, strUnid);
  edtUniDescri.Text := strDescri;
  edtUniUni.Text := strUnid;
end;

procedure TfrmCadEmbAlessi.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
   fPesqUnidade(Self, dbeCodUni, edtUniDescri, edtUniUni, Nil, key, arrSel);
end;

procedure TfrmCadEmbAlessi.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadEmb;
  strNomeTabela := 'ALE_CADEMB';
  strNomeCampo := 'EMB_NOME__';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
end;

function TfrmCadEmbAlessi.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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
        fMensagem('ATENÇÃO!', 'A embalagem deve ser preenchido!', ['OK']);
        Result := False;
      end;
    end
    else if (Sender = dbeCodUni) then
    begin
      dbeCodUniExit(dbeCodUni);
      if fEmptyStr(dbeCodUni.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['OK']);
        Result := False;
      end
      else if fEmptyStr(edtUniDescri.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['OK']);
        Result := False;
      end;
    end;
  end;  

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadEmbAlessi.pCriaDataSets;
begin
  qryCadEmb := fCriarQuery('SELECT * FROM ALE_CADEMB', Self);

  qryCadEmb.FieldByName('EMB_NOME__').DisplayLabel := 'Embalagem';  
  qryCadEmb.FieldbyName('EMB_CODUNI').DisplayLabel := 'Unidade';
  qryCadEmb.FieldbyName('EMB_QTDEMB').DisplayLabel := 'Tamanho';
  TFloatField(qryCadEmb.FieldbyName('EMB_QTDEMB')).DisplayFormat := '0.0000';

  qryCadEmb.FieldByName('AUTOINCREM').Visible := False;

  dtsCadEmb := fCriaDataSource(qryCadEmb);
end;

procedure TfrmCadEmbAlessi.pInicializaIndices;
begin
  inherited;
  stlCampos.Clear;
  stlCampos.Add('EMB_NOME__');  
  stlCampos.Add('EMB_CODUNI');
  stlCampos.Add('EMB_QTDEMB');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Clear;
  stlCamInd.Add('EMB_NOME__');
  stlCamInd.Add('EMB_CODUNI');

  stlDesInd.Clear;
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadEmbAlessi.pLigaDataSets;
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
