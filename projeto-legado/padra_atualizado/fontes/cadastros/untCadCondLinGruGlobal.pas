unit untCadCondLinGruGlobal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCadCondLinGruGlobal = class(TfrmPaiConfirma)
    pnlItem: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbl1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtCodCnd: TEditFocus;
    edtCodLinhaGru: TEditFocus;
    edtDesMaxGerJun: TEditFocus;
    edtDesMaxGerMas: TEditFocus;
    edtDesMaxSubGerJun: TEditFocus;
    edtDesMaxSubGerMas: TEditFocus;
    edtDesMaxVenJun: TEditFocus;
    edtDesMaxVenMas: TEditFocus;
    edtDesLinhaGru: TEditFocus;
    edtDesCnd: TEditFocus;
    UniQuery1: TUniQuery;
    lblLegenda: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtCodLinhaGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtDesMaxGerJunExit(Sender: TObject);
    procedure edtDesMaxSubGerJunExit(Sender: TObject);
    procedure edtDesMaxVenJunExit(Sender: TObject);
    procedure edtDesMaxGerMasExit(Sender: TObject);
    procedure edtDesMaxSubGerMasExit(Sender: TObject);
    procedure edtDesMaxVenMasExit(Sender: TObject);
  private
    { Private declarations }
    FCondicao: String;
    FLinhaGrupo: String;
    function fAlteraCondicaoGrupo: Boolean;
    function fValidaHierarquia : Boolean;
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untValidaHierarquia;

{$R *.dfm}

procedure TfrmCadCondLinGruGlobal.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if not fValidaHierarquia Then
    exit;

  If fMensagem('ATENÇÃO!','Deseja alterar o desconto da Linha/Grupo em todas as Condições de Pagamento?' +sLineBreak+
                          'Caso a Linha/Grupo não esteja vinculada a condição de pagamento, a mesma não será inserida.', ['&Sim', '&Não']) = 1 Then
  Begin

    fStartTransaction;

    If fAlteraCondicaoGrupo Then
    Begin
      fCommit;
      fMensagem('ATENÇÃO!', 'Descontos alterado com sucesso!', ['&Ok']);
    End
    Else
    Begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'Erro ao alterar desconto!', ['&Ok']);
    End;
  End;
end;

procedure TfrmCadCondLinGruGlobal.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
var
  LArrCondicao: TConsultasArray;
  LIndice: integer;
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, LArrCondicao, False) Then
  Begin
    If fValidaCampos(edtCodCnd) Then
    Begin
      If Length(LArrCondicao) > 0 Then
      Begin
        FCondicao := EmptyStr;

        For LIndice := Low(LArrCondicao) To High(LArrCondicao) Do
          pIncrementaListaStr(LArrCondicao[LIndice].strCodigo, FCondicao, True);
      End;
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCondLinGruGlobal.edtCodLinhaGruKeyPress(Sender: TObject;
  var Key: Char);
var
  LArrGrupos: TConsultasArray;
  LIndice: integer;
begin
  inherited;

  If fPesqGrupo(Self, edtCodLinhaGru, edtDesLinhaGru, Nil, Key, LArrGrupos, False) Then
  Begin
    If fValidaCampos(edtCodLinhaGru) Then
    Begin
      If Length(LArrGrupos) > 0 Then
      Begin
        FLinhaGrupo := EmptyStr;

        For LIndice := Low(LArrGrupos) To High(LArrGrupos) Do
          pIncrementaListaStr(LArrGrupos[LIndice].strCodigo, FLinhaGrupo, True);
      End;
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCondLinGruGlobal.edtDesMaxGerJunExit(Sender: TObject);
begin
  inherited;
  edtDesMaxGerJun.Text := FormatFloat('#0.00', fStrToFloat(edtDesMaxGerJun.Text));

  if fStrToFloat(edtDesMaxGerJun.Text) < 0 then
    edtDesMaxGerJun.Text := '0,00'
  else if fStrToFloat(edtDesMaxGerJun.Text) > 100 then
    edtDesMaxGerJun.Text := '100,00';
end;

procedure TfrmCadCondLinGruGlobal.edtDesMaxGerMasExit(Sender: TObject);
begin
  inherited;
  edtDesMaxGerMas.Text := FormatFloat('#0.00', fStrToFloat(edtDesMaxGerMas.Text));

  if fStrToFloat(edtDesMaxGerMas.Text) < 0 then
    edtDesMaxGerMas.Text := '0,00'
  else if fStrToFloat(edtDesMaxGerMas.Text) > 100 then
    edtDesMaxGerMas.Text := '100,00';
end;

procedure TfrmCadCondLinGruGlobal.edtDesMaxSubGerJunExit(Sender: TObject);
begin
  inherited;
  edtDesMaxSubGerJun.Text := FormatFloat('#0.00', fStrToFloat(edtDesMaxSubGerJun.Text));

  if fStrToFloat(edtDesMaxSubGerJun.Text) < 0 then
    edtDesMaxSubGerJun.Text := '0,00'
  else if fStrToFloat(edtDesMaxSubGerJun.Text) > 100 then
    edtDesMaxSubGerJun.Text := '100,00';
end;

procedure TfrmCadCondLinGruGlobal.edtDesMaxSubGerMasExit(Sender: TObject);
begin
  inherited;
  edtDesMaxSubGerMas.Text := FormatFloat('#0.00', fStrToFloat(edtDesMaxSubGerMas.Text));

  if fStrToFloat(edtDesMaxSubGerMas.Text) < 0 then
    edtDesMaxSubGerMas.Text := '0,00'
  else if fStrToFloat(edtDesMaxSubGerMas.Text) > 100 then
    edtDesMaxSubGerMas.Text := '100,00';
end;

procedure TfrmCadCondLinGruGlobal.edtDesMaxVenJunExit(Sender: TObject);
begin
  inherited;
  edtDesMaxVenJun.Text := FormatFloat('#0.00', fStrToFloat(edtDesMaxVenJun.Text));

  if fStrToFloat(edtDesMaxVenJun.Text) < 0 then
    edtDesMaxVenJun.Text := '0,00'
  else if fStrToFloat(edtDesMaxVenJun.Text) > 100 then
    edtDesMaxVenJun.Text := '100,00';
end;

procedure TfrmCadCondLinGruGlobal.edtDesMaxVenMasExit(Sender: TObject);
begin
  inherited;
  edtDesMaxVenMas.Text := FormatFloat('#0.00', fStrToFloat(edtDesMaxVenMas.Text));

  if fStrToFloat(edtDesMaxVenMas.Text) < 0 then
    edtDesMaxVenMas.Text := '0,00'
  else if fStrToFloat(edtDesMaxVenMas.Text) > 100 then
    edtDesMaxVenMas.Text := '100,00';
end;

function TfrmCadCondLinGruGlobal.fAlteraCondicaoGrupo: Boolean;
var
  LQryAltera: TUniQuery;
begin
  LQryAltera := fCriaQuery;

  try
    Result := False;

    LQryAltera.Close;
    LQryAltera.SQL.Clear;
    LQryAltera.SQL.Add('UPDATE CNDGRU');
    LQryAltera.SQL.Add('SET CND_DESMAG = :DESMAG');
    LQryAltera.SQL.Add(', CND_DESMAV = :DESMAV');
    LQryAltera.SQL.Add(', CND_DESMAS = :DESMAS');
    LQryAltera.SQL.Add(', CND_DESMGM = :DESMGM');
    LQryAltera.SQL.Add(', CND_DESMSM = :DESMSM');
    LQryAltera.SQL.Add(', CND_DESMVM = :DESMVM');

    if Length(FCondicao) > 0 then
    begin
      LQryAltera.SQL.Add('WHERE CND_CODCND IN ('+FCondicao+')');
    end
    else if (not fEmptyStr(edtCodCnd.Text)) and (not fEmptyStr(edtDesCnd.Text)) then
    begin
      LQryAltera.SQL.Add('WHERE CND_CODCND = :CODCND');
      LQryAltera.ParamByName('CODCND').AsString := edtCodCnd.Text;
    end;

    if Length(FLinhaGrupo) > 0 then
    begin
      if pos('WHERE', LQryAltera.SQL.Text) > 0 then
        LQryAltera.SQL.Add(' AND ')
      else
        LQryAltera.SQL.Add(' WHERE ');

      LQryAltera.SQL.Add('CND_CODGRU IN ('+FLinhaGrupo+')');
    end
    else if (not fEmptyStr(edtCodLinhaGru.Text)) and (not fEmptyStr(edtDesLinhaGru.Text)) then
    begin
      if pos('WHERE', LQryAltera.SQL.Text) > 0 then
        LQryAltera.SQL.Add(' AND ')
      else
        LQryAltera.SQL.Add(' WHERE ');

      LQryAltera.SQL.Add('CND_CODGRU = :CODGRU');
      LQryAltera.ParamByName('CODGRU').AsString := edtCodLinhaGru.Text;
    end;

    LQryAltera.ParamByName('DESMAG').AsFloat := StrToFloatDef(edtDesMaxGerJun.Text, 0);
    LQryAltera.ParamByName('DESMAV').AsFloat := StrToFloatDef(edtDesMaxVenJun.Text, 0);
    LQryAltera.ParamByName('DESMAS').AsFloat := StrToFloatDef(edtDesMaxSubGerJun.Text, 0);
    LQryAltera.ParamByName('DESMGM').AsFloat := StrToFloatDef(edtDesMaxGerMas.Text, 0);
    LQryAltera.ParamByName('DESMSM').AsFloat := StrToFloatDef(edtDesMaxSubGerMas.Text, 0);
    LQryAltera.ParamByName('DESMVM').AsFloat := StrToFloatDef(edtDesMaxVenMas.Text, 0);

    LQryAltera.ExecSQL;

    Result := True;

  finally
    FreeAndNil(LQryAltera);
  end;
end;


procedure TfrmCadCondLinGruGlobal.FormCreate(Sender: TObject);
begin
  inherited;
  FCondicao := EmptyStr;
  FLinhaGrupo := EmptyStr;
end;

procedure TfrmCadCondLinGruGlobal.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCnd);
end;

function TfrmCadCondLinGruGlobal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodLinhaGru) Then
    Begin
      If fEmptyStr(edtCodLinhaGru.Text) Then
      Begin
        edtDesLinhaGru.Clear;
        Exit;
      End;

      If (Not fEmptyStr(edtCodLinhaGru.Text)) And (edtDesLinhaGru.Text = '+1') Then
      Begin
        Exit;
      End;

      edtCodLinhaGru.Text := fStrZero(edtCodLinhaGru.Text, edtCodLinhaGru.TamCampo);

      edtDesLinhaGru.Text := fRetNomeLinhaGrupo(edtCodLinhaGru.Text);

      If (Not fEmptyStr(edtCodLinhaGru.Text)) And (fEmptyStr(edtDesLinhaGru.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodCnd) Then
    Begin
      If fEmptyStr(edtCodCnd.Text) Then
      Begin
        edtDesCnd.Clear;
        Exit;
      End;

      If (Not fEmptyStr(edtCodCnd.Text)) And (edtDesCnd.Text = '+1') Then
      Begin
        Exit;
      End;

      edtCodCnd.Text := fStrZero(edtCodCnd.Text, edtCodCnd.TamCampo);

      edtDesCnd.Text := fRetDesConPag(edtCodCnd.Text);

      If (Not fEmptyStr(edtCodCnd.Text)) And (fEmptyStr(edtDesCnd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Condição de pagamento não cadastrada!', ['&Ok']);
        Exit;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadCondLinGruGlobal.fValidaHierarquia : Boolean;
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin

  Result := True;

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(strToFloat(edtDesMaxVenJun.Text));
    objValidaHierarquia.pSetVendedorMaster(strToFloat(edtDesMaxVenMas.Text));
    objValidaHierarquia.pSetSubGerenJunior(strToFloat(edtDesMaxSubGerJun.Text));
    objValidaHierarquia.pSetSubGerenMaster(strToFloat(edtDesMaxSubGerMas.Text));
    objValidaHierarquia.pSetGerente_Junior(strToFloat(edtDesMaxGerJun.Text));
    objValidaHierarquia.pSetGerente_Master(strToFloat(edtDesMaxGerMas.Text));

    recResultado := objValidaHierarquia.fValidarDescontoMaximoOperador;

    If recResultado.TemInconsistencia Then
    Begin
      fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
      Result := False;
    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;

end;

end.
