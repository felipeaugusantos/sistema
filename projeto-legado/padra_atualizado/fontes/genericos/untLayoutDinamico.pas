unit untLayoutDinamico;

interface

uses System.SysUtils, Data.DB, System.UITypes, untZClient, Uni;

Type
  TTipoVisao = (tvInsercao, tvEdicao, tvVisualizacao);


  TCriaLayoutDefaut = procedure of object;

  TCampos = record
    intIdent: integer;
    strDescricao: String;
    strPosicao: String;
    obrigatorio: Boolean;
  End;

  TfuncTodosOsCamposDefaultPreenchidos = function: Boolean of object;

  TArrCampos = array of TCampos;

  TLayoutPadrao = record
    Descricao: String;
    ArrCampos: TArrCampos;
    procedure pAddCampo(ADescricao, APosicao: String; AIdent: integer; AObrigatorio: Boolean = False );
  End;



  TLayoutDinamico = class
  private
    FChave: String;
    FLayoutPadrao: TLayoutPadrao;
    FLayoutsDisponiveis: TZClient;
    FLayoutsCampos: TZClient;
    FQryComand: TUniQuery;
    FStrIncModeloPadrao: String;
    FArrCamposLayoutSelecionado: TArrCampos;
    function fGetLayoutSelecionado: String;
    procedure pInsereLayoutPadrao(LayoutPadrao: TLayoutPadrao; strAutIncDel: string = '');overload;
    procedure pInsereLayoutPadrao(strNomeLayout: string); overload;
    procedure pAjustaAlteracaoLayoutPadrao(LayoutPadrao: TLayoutPadrao);
    procedure pCarregaLayoutCampos(strAutInc: String);
    function fComparaMatriz(LayoutPadrao: TLayoutPadrao): Boolean;
    procedure pAbrirModeloInsercao(strAutInc: String; TipoVisao: TTipoVisao = tvVisualizacao; strDescricao: String = '');
    procedure pNormatizaCamposNaoCriados(AutIncLayout: String; out ATeveAlteracao: Boolean);
    procedure pAbrirModeloEdicao;
    procedure pAbreLayouteCampos(strAutInc: String; TipoVisao: TTipoVisao);
    function fTodosOsCamposDefaultPreenchidos: Boolean;
    procedure pRecreate(var ZClient: TZClient);
    procedure pExecuteDeleteModelo(strAutInc: String);
    procedure pMontaInsert(AQuery: TUniQuery; ACampo: TCampos; strAutImp: String; blnIgnoraPosLay: Boolean = False);
    procedure pRecarrega(strAutInc:String);
    procedure pCarregaCamposLayoutSelecionado;



  public
    property strLayoutSelecionado: String read fGetLayoutSelecionado;
    constructor Create(Chave: String; LayoutPadrao: TLayoutPadrao);
    destructor Destroy; override;
    function fSelecionaModelo: Boolean;
    procedure pAbrirEditorDeLayout(TipoVisao: TTipoVisao);
    procedure pRemoveModelo;
    procedure pSetDataSet(DataSource: TDataSource);
    property  ArrCamposLayoutSelecionado: TArrCampos read FArrCamposLayoutSelecionado;


end;

implementation

uses
  untFuncoesSimples, untSelecionaModelolayout, untEditorLayout;

{ TLayoutDinamico }

constructor TLayoutDinamico.Create(Chave: String; LayoutPadrao: TLayoutPadrao);
begin
  Try
    FLayoutsDisponiveis := TZClient.Create(nil);
    FLayoutsCampos := TZClient.Create(nil);
    FChave := Chave;
    FQryComand := fCriaQuery;
    FLayoutsDisponiveis.qryQuery.SQL.Add('SELECT * FROM AUTIMP WHERE LAY_LOCIMP = "'+FChave+'" AND LAY_PADRAO = "S" ');
    FLayoutsDisponiveis.fAbreClient(False);

    FLayoutsCampos.qryQuery.SQL.Add('SELECT * FROM AUTCAM WHERE LAY_AUTIMP = :LAY_AUTIMP ORDER BY LAY_IDENTI');

    If FLayoutsDisponiveis.IsEmpty Then
      pInsereLayoutPadrao(LayoutPadrao)
    Else
      pAjustaAlteracaoLayoutPadrao(LayoutPadrao);

    pRecreate(FLayoutsDisponiveis);
    FLayoutsDisponiveis.qryQuery.SQL.Add('SELECT * FROM AUTIMP WHERE LAY_LOCIMP = "'+FChave+'" AND LAY_PADRAO = "S" ');
    FLayoutsDisponiveis.fAbreClient(False);
    FStrIncModeloPadrao := FLayoutsDisponiveis.FieldByName('AUTOINCREM').AsString;

    pRecreate(FLayoutsCampos);
    FLayoutsCampos.qryQuery.SQL.Add('SELECT * FROM AUTCAM WHERE LAY_AUTIMP = "'+FStrIncModeloPadrao+'" ORDER BY LAY_IDENTI');
    FLayoutsCampos.fAbreClient(False);

    pCarregaCamposLayoutSelecionado;

  Except
    on E:Exception do
      pMensagensErro(e.message, '[TLayoutDinamico.Create]');
  End;
end;

destructor TLayoutDinamico.Destroy;
begin
  FreeAndNil(FLayoutsDisponiveis);
  FreeAndNil(FQryComand);
  FreeAndNil(FLayoutsCampos);
  inherited;
end;

function TLayoutDinamico.fComparaMatriz(LayoutPadrao: TLayoutPadrao): Boolean;
begin
  Result := True;
  If LayoutPadrao.ArrCampos[FLayoutsCampos.RecNo -1].strPosicao <> FLayoutsCampos.FieldByname('LAY_POSLAY').AsString then
    result := False
  Else If LayoutPadrao.ArrCampos[FLayoutsCampos.RecNo -1].intIdent <> FLayoutsCampos.FieldByname('LAY_IDENTI').AsInteger then
    Result := False;
end;

function TLayoutDinamico.fGetLayoutSelecionado: String;
begin
  result := FLayoutsDisponiveis.FieldByName('LAY_DESCRI').AsString;
end;

function TLayoutDinamico.fSelecionaModelo: Boolean;
  var
    frmSelecionaModeloLayout: TfrmSelecionaModeloLayout;
    strAutIncLayoutSelecionado: String;
begin
  pCriarFormularios(TfrmSelecionaModeloLayout, frmSelecionaModeloLayout);
  Try
    strAutIncLayoutSelecionado := FLayoutsDisponiveis.FieldByname('AUTOINCREM').AsString;
    frmSelecionaModeloLayout.LayoutDinamico := Self;
    pRecreate(FLayoutsDisponiveis);
    FLayoutsDisponiveis.qryQuery.SQL.Add('SELECT * FROM AUTIMP WHERE LAY_LOCIMP = "'+FChave+'" ');
    FLayoutsDisponiveis.fAbreClient(False);
    frmSelecionaModeloLayout.dtsModelos.DataSet := FLayoutsDisponiveis;
    Result := frmSelecionaModeloLayout.ShowModal = mrOk;
    If Result Then
      pRecarrega(FLayoutsDisponiveis.FieldByname('AUTOINCREM').AsString)
    Else
      pRecarrega(strAutIncLayoutSelecionado);
    pCarregaCamposLayoutSelecionado;

  Finally
    FreeAndNil(frmSelecionaModeloLayout);
  End;

end;


procedure TLayoutDinamico.pRecarrega(strAutInc:String);
begin
  pRecreate(FLayoutsDisponiveis);
  FLayoutsDisponiveis.qryQuery.SQL.Add('SELECT * FROM AUTIMP WHERE LAY_LOCIMP = "'+FChave+'" AND AUTOINCREM = "'+strAutInc+'" ');
  FLayoutsDisponiveis.fAbreClient(False);

  pRecreate(FLayoutsCampos);
  FLayoutsCampos.qryQuery.SQL.Add('SELECT * FROM AUTCAM WHERE LAY_AUTIMP = "'+strAutInc+'" ORDER BY LAY_IDENTI');
  FLayoutsCampos.fAbreClient(False);
End;

function TLayoutDinamico.fTodosOsCamposDefaultPreenchidos: Boolean;
begin
  FLayoutsCampos.Filtered := False;
  FLayoutsCampos.Filter := 'LAY_OBRIGA = ' + QuotedStr('S') + ' AND LAY_POSLAY = ' + QuotedStr('');
  FLayoutsCampos.Filtered := True;

  Result := FLayoutsCampos.IsEmpty;
  If Not Result then
    pMensagemOk('Todos os campos obrigatórios devem preenchidos!');
  FLayoutsCampos.Filtered := False;
  FLayoutsCampos.Filter := '';
end;

procedure TLayoutDinamico.pAbrirEditorDeLayout(TipoVisao: TTipoVisao);
begin
  Case TipoVisao of
    tvInsercao    : pAbrirModeloInsercao(FStrIncModeloPadrao, TipoVisao);
    tvEdicao      : pAbrirModeloEdicao;
    tvVisualizacao: pAbrirModeloInsercao(FLayoutsDisponiveis.FieldByName('AUTOINCREM').AsString, TipoVisao, FLayoutsDisponiveis.FieldByName('LAY_DESCRI').AsString);
  end;
end;

procedure TLayoutDinamico.pAbrirModeloEdicao;
begin
  If FLayoutsDisponiveis.FieldByName('LAY_PADRAO').AsString = 'S' Then
  begin
    pMensagemOk('Atenção! o modelo padrão não pode ser editado');
    Exit;
  End;
  pAbrirModeloInsercao(FLayoutsDisponiveis.FieldByName('AUTOINCREM').AsString, tvEdicao, FLayoutsDisponiveis.FieldByName('LAY_DESCRI').AsString)

end;

procedure TLayoutDinamico.pAbreLayouteCampos(strAutInc: String; TipoVisao: TTipoVisao);
begin
  FLayoutsCampos.qryQuery.SQL.Clear;
  FLayoutsCampos.qryQuery.SQL.Add('SELECT AUTOINCREM,');
  FLayoutsCampos.qryQuery.SQL.Add('       LAY_AUTIMP,  ');
  FLayoutsCampos.qryQuery.SQL.Add('       LAY_POSPAD,');
  FLayoutsCampos.qryQuery.SQL.Add('       LAY_DESCRI,');
  FLayoutsCampos.qryQuery.SQL.Add('       LAY_OBRIGA,');
  FLayoutsCampos.qryQuery.SQL.Add('     ' + IIf(TipoVisao in [tvEdicao, tvVisualizacao],' LAY_POSLAY,',  'CAST("" AS CHAR(5)) AS LAY_POSLAY,' ));
  FLayoutsCampos.qryQuery.SQL.Add('       LAY_IDENTI');
  FLayoutsCampos.qryQuery.SQL.Add('  FROM AUTCAM');
  FLayoutsCampos.qryQuery.SQL.Add(' WHERE LAY_AUTIMP = "'+strAutInc+'"');
  If TipoVisao = tvVisualizacao Then
    FLayoutsCampos.qryQuery.SQL.Add(' AND IFNULL(LAY_POSLAY, "") <> ""');
  FLayoutsCampos.qryQuery.SQL.Add(' ORDER BY LAY_IDENTI');
  FLayoutsCampos.fAbreClient(False);
End;

procedure TLayoutDinamico.pAbrirModeloInsercao(strAutInc: String; TipoVisao: TTipoVisao = tvVisualizacao; strDescricao: String = '');
var
  frmEditorLayout: TfrmEditorLayout;
  blnAlterou: Boolean;
begin
  pRecreate(FLayoutsCampos);
  pAbreLayouteCampos(strAutInc, TipoVisao);
  If TipoVisao = tvEdicao then
  Begin
    pNormatizaCamposNaoCriados(strAutInc, blnAlterou);
    If blnAlterou Then
    Begin
      pRecreate(FLayoutsCampos);
      pAbreLayouteCampos(strAutInc, TipoVisao);
    End;
  End;

  pCriarFormularios(TfrmEditorLayout, frmEditorLayout);
  Try
    frmEditorLayout.dtsCampos.DataSet := FLayoutsCampos;
    frmEditorLayout.FValidaTodosOsCamposDefaultPreenchidos := fTodosOsCamposDefaultPreenchidos;
    frmEditorLayout.edtNomLayout.Text :=  strDescricao;
    frmEditorLayout.blnModoVisualizacao :=  TipoVisao = tvVisualizacao;
    frmEditorLayout.ShowModal;
    If frmEditorLayout.blnConfirma Then
    Begin
      If TipoVisao = tvEdicao then
        pExecuteDeleteModelo(FLayoutsDisponiveis.FieldByName('AUTOINCREM').AsString);

      pInsereLayoutPadrao(frmEditorLayout.edtNomLayout.Text);
      pRecreate(FLayoutsDisponiveis);
      FLayoutsDisponiveis.qryQuery.SQL.Add('SELECT * FROM AUTIMP WHERE LAY_LOCIMP = "'+FChave+'" ');
      FLayoutsDisponiveis.fAbreClient(False);
    End;


  Finally
    FreeAndNil(frmEditorLayout);
  End;
end;

procedure TLayoutDinamico.pAjustaAlteracaoLayoutPadrao(LayoutPadrao: TLayoutPadrao);
var blnReescreve : Boolean;
begin
  blnReescreve := False;
  FLayoutPadrao := LayoutPadrao;
  pCarregaLayoutCampos(FLayoutsDisponiveis.FieldByname('AUTOINCREM').AsString);
  If Length(LayoutPadrao.ArrCampos) <> FLayoutsCampos.RecordCount Then
    blnReescreve := True;
  //Campara Matriz com os dados
  If not blnReescreve then
  begin
    While Not FLayoutsCampos.Eof Do
    begin
      blnReescreve := Not fComparaMatriz(LayoutPadrao);
      If blnReescreve Then
        Break;
      FLayoutsCampos.Next;
    End;
  End;

  If blnReescreve  then
    pInsereLayoutPadrao(LayoutPadrao, FLayoutsDisponiveis.FieldByname('AUTOINCREM').AsString);

end;

procedure TLayoutDinamico.pCarregaCamposLayoutSelecionado;
begin
 SetLength(FArrCamposLayoutSelecionado, 0);
 SetLength(FArrCamposLayoutSelecionado, FLayoutsCampos.RecordCount + 1);

 FLayoutsCampos.First;

 While not FLayoutsCampos.Eof Do
 Begin
   FArrCamposLayoutSelecionado[FLayoutsCampos.FieldByName('LAY_IDENTI').AsInteger -1].intIdent :=  FLayoutsCampos.FieldByName('LAY_IDENTI').AsInteger;
   FArrCamposLayoutSelecionado[FLayoutsCampos.FieldByName('LAY_IDENTI').AsInteger -1].strDescricao := FLayoutsCampos.FieldByName('LAY_DESCRI').AsString;
   FArrCamposLayoutSelecionado[FLayoutsCampos.FieldByName('LAY_IDENTI').AsInteger -1].strPosicao := FLayoutsCampos.FieldByName('LAY_POSLAY').AsString;
   FLayoutsCampos.Next;
 End;
end;

procedure TLayoutDinamico.pCarregaLayoutCampos(strAutInc: String);
begin
  FLayoutsCampos.qryQuery.ParamByName('LAY_AUTIMP').AsString := strAutInc;
  FLayoutsCampos.fAbreClient(False);


end;

procedure TLayoutDinamico.pInsereLayoutPadrao(strNomeLayout: string);
var strAutImp: String;
begin
  Try
    strAutImp := fRetAutoIncrem('AUTIMP', VS_StrCodEmp);
    FQryComand.SQL.Clear;
    FQryComand.SQL.Add('INSERT INTO AUTIMP(');
    FQryComand.SQL.Add('   AUTOINCREM,');
    FQryComand.SQL.Add('   LAY_DESCRI,');
    FQryComand.SQL.Add('   LAY_PADRAO,');
    FQryComand.SQL.Add('   LAY_LOCIMP)VALUES(');
    FQryComand.SQL.Add('   "'+strAutImp+'",');
    FQryComand.SQL.Add('   "'+strNomeLayout+'",');
    FQryComand.SQL.Add('   "N",');
    FQryComand.SQL.Add('   "'+FChave+'");');
    FLayoutsCampos.First;
    While not FLayoutsCampos.Eof Do
    Begin
      FQryComand.SQL.Add('INSERT INTO AUTCAM(AUTOINCREM, LAY_AUTIMP, LAY_POSPAD, LAY_DESCRI, LAY_POSLAY, LAY_OBRIGA, LAY_IDENTI) VALUES (');
      FQryComand.SQL.Add('   "'+fRetAutoincrem('AUTCAM', VS_StrCodEmp)+'",');
      FQryComand.SQL.Add('   "'+strAutImp+'",');
      FQryComand.SQL.Add('   "'+FLayoutsCampos.FieldByName('LAY_POSPAD').AsString+'",');
      FQryComand.SQL.Add('   "'+FLayoutsCampos.FieldByName('LAY_DESCRI').AsString+'",');
      FQryComand.SQL.Add('   "'+FLayoutsCampos.FieldByName('LAY_POSLAY').AsString+'",');
      FQryComand.SQL.Add('   "'+FLayoutsCampos.FieldByName('LAY_OBRIGA').AsString+'",');
      FQryComand.SQL.Add('    '+FLayoutsCampos.FieldByName('LAY_IDENTI').AsString+');');
      FLayoutsCampos.Next;
    End;
    FQryComand.ExecSQL;
  Except
    on e: Exception do
      pMensagensErro(e.message, 'TLayoutDinamico.pInsereLayoutPadrao(strNomeLayout: string)')
  End;
end;

procedure TLayoutDinamico.pNormatizaCamposNaoCriados(AutIncLayout: String; out ATeveAlteracao: Boolean);
var Campos: TCampos;
begin
  ATeveAlteracao := False;
  FQryComand.SQl.Clear;
  For Campos in FLayoutPadrao.ArrCampos do
  begin
    FLayoutsCampos.First;
    If  not FLayoutsCampos.Locate('LAY_IDENTI', Campos.intIdent, []) Then
    begin
      ATeveAlteracao := True;
      pMontaInsert(FQryComand, Campos,  AutIncLayout, True);
    end;
  End;
  If ATeveAlteracao Then
    FQryComand.ExecSQL;



end;

procedure TLayoutDinamico.pRecreate(var ZClient: TZClient);
begin
   FreeAndNil(ZClient);
   ZClient := TZClient.Create(nil);
end;

procedure TLayoutDinamico.pRemoveModelo;
begin
  If FLayoutsDisponiveis.FieldByName('LAY_PADRAO').AsString = 'S' Then
  begin
    pMensagemOk('Atenção! o modelo padrão não pode ser excluido!');
    Exit;
  End;
  pExecuteDeleteModelo(FLayoutsDisponiveis.FieldByName('AUTOINCREM').AsString);
  pRecreate(FLayoutsDisponiveis);
  FLayoutsDisponiveis.qryQuery.SQL.Add('SELECT * FROM AUTIMP WHERE LAY_LOCIMP = "'+FChave+'" ');
  FLayoutsDisponiveis.fAbreClient(False);
end;

procedure TLayoutDinamico.pSetDataSet(DataSource: TDataSource);
begin
  DataSource.DataSet := FLayoutsDisponiveis;
end;

procedure TLayoutDinamico.pExecuteDeleteModelo(strAutInc: String);
begin
  FQryComand.SQL.Clear;
  FQryComand.SQL.Add('DELETE FROM AUTIMP WHERE AUTOINCREM = "'+strAutInc+'";');
  FQryComand.ExecSQL;
End;

procedure TLayoutDinamico.pMontaInsert(AQuery: TUniQuery; ACampo: TCampos; strAutImp: String; blnIgnoraPosLay: Boolean = False );
begin
  FQryComand.SQL.Add('INSERT INTO AUTCAM(AUTOINCREM, LAY_AUTIMP, LAY_POSPAD, LAY_DESCRI, LAY_POSLAY, LAY_OBRIGA, LAY_IDENTI) VALUES (');
  FQryComand.SQL.Add('   "'+fRetAutoincrem('AUTCAM', VS_StrCodEmp)+'",');
  FQryComand.SQL.Add('   "'+strAutImp+'",');
  FQryComand.SQL.Add('   "'+ACampo.strPosicao+'",');
  FQryComand.SQL.Add('   "'+ACampo.strDescricao+'",');
  If blnIgnoraPosLay Then
    FQryComand.SQL.Add('   "",')
  Else
    FQryComand.SQL.Add('   "'+ACampo.strPosicao+'",');
  FQryComand.SQL.Add('   "'+IIF(ACampo.obrigatorio, 'S', 'N')+'",');
  FQryComand.SQL.Add('   '+IntToStr(ACampo.intIdent)+');');
End;


procedure TLayoutDinamico.pInsereLayoutPadrao(LayoutPadrao: TLayoutPadrao; strAutIncDel: string = '');
var Campos: TCampos;
    strAutImp: String;
begin
  try
    strAutImp := fRetAutoIncrem('AUTIMP', VS_StrCodEmp);
    FQryComand.SQL.Clear;
    If strAutIncDel <> '' Then
      pExecuteDeleteModelo(strAutIncDel);
    FQryComand.SQL.Add('INSERT INTO AUTIMP(');
    FQryComand.SQL.Add('   AUTOINCREM,');
    FQryComand.SQL.Add('   LAY_DESCRI,');
    FQryComand.SQL.Add('   LAY_PADRAO,');
    FQryComand.SQL.Add('   LAY_LOCIMP)VALUES(');
    FQryComand.SQL.Add('   "'+strAutImp+'",');
    FQryComand.SQL.Add('   "'+LayoutPadrao.Descricao+'",');
    FQryComand.SQL.Add('   "S",');
    FQryComand.SQL.Add('   "'+FChave+'");');
    For Campos in LayoutPadrao.ArrCampos do
      pMontaInsert(FQryComand, Campos, strAutImp);
    FQryComand.ExecSQL;
  Except
    on e: Exception do
      pMensagensErro(e.message, 'TLayoutDinamico.pInsereLayoutPadrao')
  End;

end;

{ TLayoutPadrao }

procedure TLayoutPadrao.pAddCampo(ADescricao, APosicao: String; AIdent: integer; AObrigatorio: Boolean = False);
var tamanho: integer;
begin
  tamanho := Length(ArrCampos) + 1;
  If tamanho = 0 then
    tamanho := 1;
  SetLength(ArrCampos, tamanho);

  ArrCampos[tamanho -1].intIdent := AIdent;
  ArrCampos[tamanho -1].strDescricao := ADescricao;
  ArrCampos[tamanho -1].strPosicao := APosicao;
  ArrCampos[tamanho -1].obrigatorio := AObrigatorio;


end;

end.
