unit untGarantiaRecCliente.LiberacaoCredito;

interface

uses
  System.Generics.Collections,
  System.Classes,
  untLiberacao;

Type
  TItemGarantia = class
  Private
    FstrCodigo: String;
    FstrDescricao: String;
    FcurCredito: Currency;
    FstrSeqDoc: String;
    FstrAutIncGer: String;
    FstrNumDoc: String;
    FblnAutorizado: Boolean;
    FstrEmpDoc: String;
    FstrEspDoc: String;
    FstrNumDocOriginal: String;
    procedure pSetstrNumDoc(Const Value: String);
  Public
    property strNumDocOriginal: String Read FstrNumDocOriginal;
    property strEmpDoc    : String Read FstrEmpDoc Write FstrEmpDoc;
    property strCodigo    : String Read FstrCodigo Write FstrCodigo;
    property strDescricao : String Read FstrDescricao Write FstrDescricao;
    property curCredito   : Currency Read FcurCredito Write FcurCredito;
    property strNumDoc    : String Read FstrNumDoc Write pSetstrNumDoc;
    property strSeqDoc    : String Read FstrSeqDoc Write FstrSeqDoc;
    property strAutIncGer : String Read FstrAutIncGer Write FstrAutIncGer;
    property strEspDoc    : string Read FstrEspDoc Write FstrEspDoc;
    property blnAutorizado: Boolean Read FblnAutorizado Write FblnAutorizado;
  end;

Type
  TListaItensGarantia = TObjectList<TItemGarantia>;

Type
  TDuplicata = class
  private
    FstrAutIncGer: String;
    FstrNumero: String;
    FstrEspecie: STring;
    FstrCodEmp: String;
    FstrCliente: String;
    FstrNomeCliente: String;
    FstrParcela: String;
    FdtaVencimento: TDateTime;
    FcurValorOriginal: Currency;
    FcurValorPago: Currency;
    FcurValorDup: Currency;
    FCurValorJuros: Currency;
    FblnLiberado: Boolean;
    function fGetValorCorrigido: Currency;
    function fGetDiasAtraso: Integer;
  Public
    Constructor Create(Const strAutIncGer: String);
    property strAutIncGer: String Read FstrAutIncGer;
    property strNumero: String Read FstrNumero Write FstrNumero;
    property strEspecie: STring Read FstrEspecie Write FstrEspecie;
    property strCodEmp: String Read FstrCodEmp Write FstrCodEmp;
    property strCliente: String Read FstrCliente Write FstrCliente;
    property strNomeCliente: String Read FstrNomeCliente Write FstrNomeCliente;
    property strParcela: String Read FstrParcela Write FstrParcela;
    property dtaVencimento: TDateTime Read FdtaVencimento Write FdtaVencimento;
    property curValorOriginal: Currency Read FcurValorOriginal Write FcurValorOriginal;
    property curValorPago: Currency Read FcurValorPago Write FcurValorPago;
    property curValorDup: Currency Read FcurValorDup Write FcurValorDup;
    property curValorCorrigido: Currency Read fGetValorCorrigido;
    property curValorJuros: Currency Read FCurValorJuros Write FCurValorJuros;
    property intDiasAtraso: Integer Read fGetDiasAtraso;
    property blnLiberado: Boolean Read FblnLiberado Write FblnLiberado Default False;

    function fCodigoNomeCliente: String;
  end;

Type
  TListaDuplicatas = TObjectlist<TDuplicata>;


Type
  TRetornaItem = procedure(Const strCodIte, strNumDoc, strSeqDoc: String) of object;

Type
  TLiberacaoCreditos = class
  Private
    FRetornaItemNaoAutorizado: TRetornaItem;
    FListaItensGarantia : TListaItensGarantia;
    FListaDuplicatas: TListaDuplicatas;
    FobjLiberacao : TLiberacao;
    FstrCliente: String;
    FstrNomeCliente: String;
    FstrFavorecido: String;
    FStrFavorecidoNome: String;
    FblnModoDevolucao: Boolean;
    FblnTemDuplicata: Boolean;

  private
    function fGeraLinhaCabecalhoLiberacao: String;
    function fGeraLinhaMsgLiberacao(const aDuplicata: TDuplicata): String;
    function fObterLiberacao(Const strAutIncGer: String): Boolean;
    function fScriptGetDuplicata: String;
    function fLocalizarItem(Const strCodIte, strNumDoc, strSeqDoc: String): Integer;
    function fObterListaMovGerProcessar: TStringList;
    function fLiberarDuplicata(Const strAutIncGer: String): Boolean;
    function fExibirTextoDuplicada(Const strAutIncGer: String): Boolean;
    function fScriptObterItensDevolucao: String;

    procedure pConfiguraObjLiberacao;
    procedure pMarcaDesmarcaLiberado(Const strAutIncGer: String; Const Liberado: Boolean);
    procedure pPesquisarDuplicata(const strNumDoc, strEspDoc, strCodCli, strCodEmp: String; Out strAutIncGer: String);
    procedure pAddTextoItemGarantia(Const aItem: TItemGarantia);
    procedure pExibirTextoItensGarantia(Const strAutIncGer: String);
    procedure pIdentificarItens(Const strNumDoc, strEspDoc, strCodCli, strCodEmp, strAutIncGer: String);
    procedure pCarregarDuplicatas;
    procedure pExibirDuplicatasEmTelaMsg(Const strAutIncGer: String);
  public
    Constructor Create;
    Destructor Destroy;override;
    property RetornaItemNaoAutorizado: TRetornaItem Write FRetornaItemNaoAutorizado;

    function fExecutar: Boolean;

    procedure pDevolverItensNaoAutorizados;
    procedure pInserirCliente(Const strCodigoCliente, strNomeCliente: String; strFavorecido: String = '';
      strFavorecidoNome: String = '');
    procedure pInserirItem(Const strCodIte, strDescIte, strSeqDoc, strNumDoc, strEmpDoc : String; Const curCredito: Currency);
    procedure pInserirItensDevolucao(const strNumDoc, strEspDoc, strEmpDoc, strCodCli: String);
    procedure pLimpar;
    property blnTemDuplicata: boolean Read FblnTemDuplicata;
  end;

implementation

uses
  untFuncoesSimples, Uni, untFuncFat, System.SysUtils, Math, Data.DB, untMsgErroSQL, untMsgLiberacao;

Const
  ESPACO_VAZIO: String = ' ';
  TAM_DUPLICATA: Integer = 13;
  TAM_ESPECIE_DOC: Integer = 8;
  TAM_EMP: Integer = 4;
  TAM_NOMECLIENTE: Integer = 42;
  TAM_DATA: Integer = 11;
  TAM_ATRASO: Integer = 8;
  TAM_VALOR: Integer = 15;
  MASCARA_MOEDA: String = '#,##0.00';
  MASCARA_DATA: String = 'dd/mm/yyyy';

{ TDuplicata }

constructor TDuplicata.Create(const strAutIncGer: String);
begin
  FstrAutIncGer := strAutIncGer;
end;

function TDuplicata.fCodigoNomeCliente: String;
begin
  Result := Format('%s - %s',[Self.strCliente, self.strNomeCliente]);
end;

function TDuplicata.fGetDiasAtraso: Integer;
begin
  Result := 0;

  if Self.curValorDup = 0 then
    Exit(Result);

  if VS_Date > FDtaVencimento then
    Result := Trunc(VS_Date - FDtaVencimento);

end;

function TDuplicata.fGetValorCorrigido: Currency;
begin
  Result := (Self.curValorJuros + Self.curValorOriginal);
end;

{ TLiberacaoCreditos }

constructor TLiberacaoCreditos.Create;
begin
  FblnModoDevolucao := False;
  FRetornaItemNaoAutorizado := nil;
  FListaItensGarantia := TListaItensGarantia.Create;
  FListaDuplicatas := TListaDuplicatas.Create;
  FobjLiberacao := TLiberacao.Create;
  FblnTemDuplicata := False;
end;

destructor TLiberacaoCreditos.Destroy;
begin
  FRetornaItemNaoAutorizado := nil;
  FListaItensGarantia.clear;
  FListaDuplicatas.Clear;
  FListaDuplicatas.Free;
  FListaItensGarantia.Free;
  FobjLiberacao.Free;
  inherited;
end;

procedure TLiberacaoCreditos.pInserirCliente(Const strCodigoCliente, strNomeCliente: String; strFavorecido: String = '';
      strFavorecidoNome: String = '');
begin
  pLimpar;
  FstrCliente := strCodigoCliente;
  FstrNomeCliente := strNomeCliente;
  if FEmptyStr(strFavorecido) then
  begin
    FStrFavorecido := FstrCliente;
    FstrFavorecidoNome := FstrNomeCliente;
  end
  else begin
    FStrFavorecido := strFavorecido;
    FstrFavorecidoNome := strFavorecidoNome;
  end;
end;

procedure TLiberacaoCreditos.pInserirItem(const strCodIte, strDescIte, strSeqDoc, strNumDoc, strEmpDoc: String; const curCredito: Currency);
Var
  aItem: TItemGarantia;
  i: integer;
  blnItemEncontrado: Boolean;
begin
  i := fLocalizarItem(strCodIte, strNumDoc, strSeqDoc);

  blnItemEncontrado := i >= 0;

  if blnItemEncontrado then
  begin
    aItem := FListaItensGarantia[i];
  end
  else
  begin
    aItem := TItemGarantia.Create;
    aItem.strCodigo     := strCodIte;
    aItem.strNumDoc     := strNumDoc;
    aItem.strDescricao  := strDescIte;
    aItem.strSeqDoc     := strSeqDoc;
    aItem.strEmpDoc     := strEmpDoc;
    aItem.strAutIncGer  := '';
    FListaItensGarantia.Add(aItem);
  end;
  aItem.curCredito := curCredito;
end;

procedure TLiberacaoCreditos.pInserirItensDevolucao(const strNumDoc, strEspDoc, strEmpDoc, strCodCli: String);
Var
  Qry: TUniQuery;
  FldAutIncDet, FldCodIte, FldDesIte, FldTotIte: TField;
  strAuxNumDoc: String;
begin
  Qry := nil;
  Try
    Qry := fCriaQuery();
    Qry.Close;
    Qry.Sql.Clear;
    Qry.sql.Add(fScriptObterItensDevolucao);
    Qry.ParamByName('NUMDOC').AsString := strNumDoc;
    Qry.ParamByName('CODCLI').AsString := strCodCli;
    Qry.ParamByName('ESPDOC').AsString := strEspDoc;
    Qry.ParamByName('CODEMP').AsString := strEmpDoc;
    Qry.Open;
    if Qry.Active then
    begin
      FldAutIncDet  := Qry.FieldByName('AUTOINCREM');
      FldCodIte     :=  Qry.FieldByName('DET_CODITE');
      FldDesIte     :=  Qry.FieldByName('ITE_DESITE');
      FldTotIte     :=  Qry.FieldByName('DET_TOTITE');

      if Not Qry.IsEmpty then
      begin
        FblnModoDevolucao := True;
        Qry.First;
        while Not Qry.Eof do
        begin
          strAuxNumDoc := (strNumDoc+'-'+strEspDoc);
          pInserirItem(FldCodIte.AsString,
                       FldDesIte.AsString,
                       FldAutIncDet.AsString,
                       strAuxNumDoc,
                       strEmpDoc,
                       FldTotIte.AsCurrency);

          Qry.Next;
        end;
      end;
      Qry.Close;
    end;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TLiberacaoCreditos.fExecutar: Boolean;
Var
  ListastrMovGer: TStringList;
  i: Integer;
  ContNegado: Integer;
begin
  if FListaItensGarantia.Count = 0 then
    Exit(True);

  ContNegado := 0;
  Result := True;

  pCarregarDuplicatas;
  ListastrMovGer := fObterListaMovGerProcessar;

  if Not Assigned(ListastrMovGer) then
  begin
    Exit(Result);
  end;

  FblnTemDuplicata := True;

  Try
    for i := 0 to ListastrMovGer.Count -1 do
    begin
      if FblnModoDevolucao then
      begin
        pExibirDuplicatasEmTelaMsg(ListastrMovGer[i]);
      end
      else
      begin
        if Not fLiberarDuplicata(ListastrMovGer[i]) then
        begin
          inc(ContNegado);
        end;
      end;
    end;
  Finally
    if Assigned(ListastrMovGer) then
    begin
      FreeAndNil(ListastrMovGer);
    end;
    Result := ContNegado = 0;
  End;
end;

procedure TLiberacaoCreditos.pCarregarDuplicatas;
Var
  Item: TItemGarantia;
  strAutIncGer: String;
begin
  for Item in FListaItensGarantia do
  begin
    if Not fEmptyStr(Item.strAutIncGer) then
      Continue;

    pPesquisarDuplicata(Item.strNumDoc, Item.strEspDoc, FstrCliente, Item.strEmpDoc, strAutIncGer);

    if Not fEmptystr(strAutIncGer) then
    begin
      pIdentificarItens(Item.strNumDoc, Item.strEspDoc, FstrCliente, Item.strEmpDoc, strAutIncGer)
    end
    else
    begin
      //Duplicata não localizada, logo não é necessário obter autorizacao
      Item.blnAutorizado := True;
    end;
  end;
end;

procedure TLiberacaoCreditos.pPesquisarDuplicata(const strNumDoc, strEspDoc, strCodCli, strCodEmp: String; Out strAutIncGer: String);
Var
  Qry: TUniQuery;
  aDuplicata: TDuplicata;
begin
  strAutIncGer := EmptyStr;
  Try
    Qry := fCriaQuery();
    Qry.close;
    Qry.sql.clear;
    Qry.sql.add(fScriptGetDuplicata);
    Qry.ParamByName('NUMDUP').AsString := strNumDoc;
    Qry.ParamByName('CODCLI').AsString := strCodCli;
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.ParamByName('ESPDOC').AsString := strEspDoc;
    Qry.Open;
    if Qry.Active then
    begin
      if Not Qry.IsEmpty then
      begin
        Qry.First;
        while Not Qry.Eof do
        begin
          strAutIncGer := Qry.FieldByname('AUTOINCREM').AsString;
          aDuplicata := TDuplicata.Create(strAutIncGer);
          aDuplicata.strNumero            := Qry.FieldByname('CTR_NUMDUP').AsString;
          aDuplicata.strCodEmp            := Qry.FieldByname('CTR_CODEMP').AsString;
          aDuplicata.strCliente           := Qry.FieldByname('CTR_CODCLI').AsString;
          aDuplicata.strNomeCliente       := Qry.FieldByname('CLI_NOMCLI').AsString;
          aDuplicata.strEspecie           := Qry.FieldByname('CTR_ESPDOC').AsString;
          aDuplicata.strParcela           := Qry.FieldByname('CTR_PARCEL').AsString;
          aDuplicata.dtaVencimento        := Qry.FieldByname('CTR_DTAVEN').AsDateTime;
          aDuplicata.curValorOriginal     := Qry.FieldByname('CTR_VALORI').AsCurrency;
          aDuplicata.curValorPago         := Qry.FieldByname('CTR_VALPGO').AsCurrency;
          aDuplicata.curValorDup          := Qry.FieldByname('CTR_VALDUP').AsCurrency;
          aDuplicata.curValorJuros         := Qry.FieldByname('CTR_VALJUR').AsCurrency;
          aDuplicata.blnLiberado          := False;
          FListaDuplicatas.Add(aDuplicata);
          Qry.Next;
        end;
      end;
      Qry.Close;
    end;
  Finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  End;
end;

procedure TLiberacaoCreditos.pExibirDuplicatasEmTelaMsg(Const strAutIncGer: String);
Var
  Texto: String;
  aDuplicata: TDuplicata;
begin
  frmMsgErroSQL := nil;
  Try
    frmMsgErroSQL := TfrmMsgErroSQL.Create(nil);
    frmMsgErroSql.Width := 1100;
    frmMsgErroSql.Caption :=    '';
    frmMsgErroSql.Panel1.Visible := False;
    frmMsgErroSql.mmoErrSQL.Font.Name := 'Consolas';
    frmMsgErroSql.mmoErrSQL.Font.Style:= [];
    frmMsgErroSql.mmoErrSQL.Lines.Add(fGeraLinhaCabecalhoLiberacao);

    for aDuplicata in FListaDuplicatas do
    begin
      if aDuplicata.strAutIncGer = strAutIncGer then
      begin
        Texto := fGeraLinhaMsgLiberacao(aDuplicata);
        frmMsgErroSql.mmoErrSQL.Lines.Add(Texto);
      end;
    end;

    frmMsgErroSql.ShowModal;

  Finally
    if Assigned(frmMsgErroSQL) then
    begin
      FreeAndNil(frmMsgErroSQL);
    end;
  End;
end;

function TLiberacaoCreditos.fLiberarDuplicata(const strAutIncGer: String): Boolean;
begin
  if fObterLiberacao(strAutIncGer) then
  begin
    Result := True;
    pMarcaDesmarcaLiberado(strAutIncGer, True);
  end
  else
  begin
    Result := False;
  end;
end;

function TLiberacaoCreditos.fObterLiberacao(const strAutIncGer: String): Boolean;
Var
  blnLocalizado: Boolean;

begin
  Result := False;

  pConfiguraObjLiberacao;

  //exibir dados itens
  if Not FblnModoDevolucao then
  begin
    pExibirTextoItensGarantia(strAutIncGer);
  end;

  //exibir dados duplicatas
  blnLocalizado := fExibirTextoDuplicada(strAutIncGer);

  if blnLocalizado then
  begin
    if Not Result then
    begin
      Result := FobjLiberacao.fLibera;
    end;

    if FblnModoDevolucao then
    begin
      Result := True;
    end;
  end
  else
  begin
    //considera liberado porque não foram encontradas duplicatas pertencentes ao AutoIncGer (MovGer) informado
    Result := True;
  end;
end;

function TLiberacaoCreditos.fLocalizarItem(const strCodIte, strNumDoc, strSeqDoc: String): Integer;
Var
  I: Integer;
  blnConfere: Boolean;
begin
  Result := -1;
  if FListaItensGarantia.Count = 0 then
    Exit(Result);

  for i := 0 to (FListaItensGarantia.Count -1) do
  begin
    blnConfere := FListaItensGarantia[i].strCodigo = strCodIte;

    if blnConfere then
      blnConfere := FListaItensGarantia[i].strSeqDoc = strSeqDoc;

    if blnConfere then
      blnConfere := FListaItensGarantia[i].strNumDoc = strNumDoc;

    if blnConfere then
    begin
      Result := i;
      Break;
    end;
  end;

end;

function TLiberacaoCreditos.fObterListaMovGerProcessar: TStringList;
Var
  Item: TItemGarantia;
  strUltimoInserido: String;
  blnEncontrado: Boolean;
  Lista: TStringList;
  i: Integer;
begin
  Result := nil;
  Lista  := nil;
  if FListaItensGarantia.Count = 0 then
    Exit(Result);

  strUltimoInserido := EmptyStr;

  for Item in FListaItensGarantia do
  begin
    if fEmptyStr(Item.strAutIncGer) then
      Continue;

    if Not Assigned(Lista) then
      Lista := TStringlist.Create;

    if Item.strAutIncGer <> strUltimoInserido then
    begin
      blnEncontrado := False;
      For i := 0 to Lista.Count -1 do
      begin
        blnEncontrado := (Item.strAutIncGer = Lista[i]);

        if blnEncontrado then
          Break;
      end;

      if Not blnEncontrado then
      begin
        Lista.add(Item.strAutIncGer);
        strUltimoInserido := Item.strAutIncGer;
      end;
    end;
  end;

  Result := Lista;
end;

procedure TLiberacaoCreditos.pIdentificarItens(const strNumDoc, strEspDoc, strCodCli, strCodEmp, strAutIncGer: String);
Var
  Item: TItemGarantia;
  blnConfere: Boolean;
begin
  for Item in FListaItensGarantia do
  begin
    if Not fEmptyStr(Item.strAutIncGer) then
      Continue;

    blnConfere := Item.strNumDoc = strNumDoc;

    if blnConfere then
      blnConfere := Item.strEspDoc = strEspDoc;

    if blnConfere then
      blnConfere := Item.strEmpDoc = strCodEmp;

    if blnConfere then
      Item.strAutIncGer := strAutIncGer;
  end;
end;

procedure TLiberacaoCreditos.pConfiguraObjLiberacao;
begin
  FobjLiberacao.Clear;
  if Not FblnModoDevolucao then
  begin
    FobjLiberacao.strDirAce  := 'SECDGA';
    FobjLiberacao.strSenLib  := fCfgSis('SECDGA');
    FobjLiberacao.strMsgSen  := 'Consulta duplicata - Liberação de crédito Cliente(Garantia)';
  end;
  FobjLiberacao.strCodOpe  := strLoginUsuarioLogado;
  FobjLiberacao.strCodDig  := strLoginUsuarioLogado;
  FobjLiberacao.strCliente := FstrFavorecido + '-' + FstrFavorecidoNome;

  if Not FblnModoDevolucao then
  begin
    FobjLiberacao.objMsgLibera.pAddTexto('Senha para liberar e geração de crédito para o cliente referente a garantia dos itens abaixo.');
    FobjLiberacao.objMsgLibera.pAddTexto('Item cujo crédito não for liberado será removido. ');
    FobjLiberacao.objMsgLibera.pAddTexto('Itens de garantia: ');
  end;

end;

function TLiberacaoCreditos.fExibirTextoDuplicada(const strAutIncGer: String): Boolean;
Var
  Texto: String;
  aDuplicata: TDuplicata;

begin
  FobjLiberacao.objMsgLibera.pAddTexto(fGeraLinhaCabecalhoLiberacao);
  Result := False;
  for aDuplicata in FListaDuplicatas do
  begin
    if aDuplicata.strAutIncGer = strAutIncGer then
    begin
      Texto := fGeraLinhaMsgLiberacao(aDuplicata);
      FobjLiberacao.objMsgLibera.pAddTexto(Texto);

      if Not Result then
        Result := True;
    end;
  end;
end;

procedure TLiberacaoCreditos.pExibirTextoItensGarantia(const strAutIncGer: String);
Var
  aItem: TItemGarantia;
  TotalGarantia: Currency;
  Msg: String;
begin
  TotalGarantia := 0;
  for aItem in FListaItensGarantia do
  begin
    if aItem.strAutIncGer = strAutIncGer then
    begin
      TotalGarantia := TotalGarantia + aItem.curCredito;
      pAddTextoItemGarantia(aItem);
    end;
  end;
  Msg := fPadL('-',50,'-');
  FobjLiberacao.objMsgLibera.pAddTexto(Msg);
  Msg := Format('Valor total do crédito: %s',[FormatFloat(MASCARA_MOEDA, TotalGarantia)]);
  FobjLiberacao.objMsgLibera.pAddTexto(Msg);
  FobjLiberacao.objMsgLibera.pAddQuebra();
end;

procedure TLiberacaoCreditos.pDevolverItensNaoAutorizados;
Var
  aItem: TItemGarantia;
begin
  if Not Assigned(FRetornaItemNaoAutorizado) then
    Exit;

  for aItem in FListaItensGarantia do
  begin
    if Not aItem.FblnAutorizado then
    begin
      FRetornaItemNaoAutorizado(aItem.strCodigo,
                                aItem.strNumDocOriginal,
                                aItem.strSeqDoc);
    end;
  end;
end;

procedure TLiberacaoCreditos.pLimpar;
begin
  FblnModoDevolucao := False;
  FstrCliente := EmptyStr;
  FstrNomeCliente := EmptyStr;
  FListaDuplicatas.clear;
  FListaItensGarantia.Clear;
end;

procedure TLiberacaoCreditos.pMarcaDesmarcaLiberado(const strAutIncGer: String; const Liberado: Boolean);
Var
  aItem: TItemGarantia;
begin
  for aItem in FListaItensGarantia do
  begin
    if aItem.strAutIncGer = strAutIncGer then
    begin
      aItem.blnAutorizado := Liberado;
    end;
  end;
end;

procedure TLiberacaoCreditos.pAddTextoItemGarantia(const aItem: TItemGarantia);
Var
  MsgItem: String;
begin
  MsgItem := Format('%s-%s',[aitem.strCodigo,
                             aitem.strDescricao]);
  FobjLiberacao.objMsgLibera.pAddTexto(MsgItem);

  MsgItem := Format('Valor do crédito sob o item: %s',[FormatFloat(MASCARA_MOEDA,aItem.curCredito)]);
  FobjLiberacao.objMsgLibera.pAddTexto(MsgItem);
end;

function TLiberacaoCreditos.fGeraLinhaCabecalhoLiberacao: String;
Var
  Msg: String;
begin
//          10        20        30        40        50        60        70        80        90        100       110       120       130       140
// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
// DUPLICATA     ESPECIE  EMP  NOMECLIENTE                                 VENCIMENTO    ATRASO     VR Original    VR Corrigido          VR Pago
// 000000000000  NF       001  NOMECLIENTE

  Msg := fPadR('Duplicata', TAM_DUPLICATA);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadR('Espécie',TAM_ESPECIE_DOC);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadR('EMP',TAM_EMP);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadR('Cliente',TAM_NOMECLIENTE);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL('Vencimento',TAM_DATA);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL('Atraso',TAM_ATRASO);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL('VR Original',TAM_VALOR);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL('VR Corrigido',TAM_VALOR);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL('VR Pago',TAM_VALOR);
  Result := Msg;
end;

function TLiberacaoCreditos.fGeraLinhaMsgLiberacao(const aDuplicata: TDuplicata): String;
Var
  Msg: String;
  Aux: String;
begin
// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
// DUPLICATA     ESPECIE  EMP  NOMECLIENTE                                        VENCIMENTO      ATRASO  VR Original    VR Corrigido   VR Pago
// 000000000000  NF       001  NOMECLIENTE


  Msg := fPadR(aDuplicata.strNumero, TAM_DUPLICATA);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadR(aDuplicata.strEspecie,TAM_ESPECIE_DOC);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadR(aDuplicata.strCodEmp,TAM_EMP);
  Msg := Msg + ESPACO_VAZIO;
  Aux := Trim(aDuplicata.fCodigoNomeCliente);

  if Length(Trim(Aux)) > TAM_NOMECLIENTE  then
    Aux := Copy(Aux,1, TAM_NOMECLIENTE);

  Msg := Msg + fPadR(Aux,TAM_NOMECLIENTE);

  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL(FormatDateTime(MASCARA_DATA, aDuplicata.dtaVencimento),TAM_DATA);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL(IntToStr(aDuplicata.intDiasAtraso),TAM_ATRASO);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL(FormatCurr(MASCARA_MOEDA, RoundTo(aDuplicata.curValorOriginal, -2)),TAM_VALOR);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL(FormatCurr(MASCARA_MOEDA, RoundTo(aDuplicata.curValorCorrigido, -2)),TAM_VALOR);
  Msg := Msg + ESPACO_VAZIO;
  Msg := Msg + fPadL(FormatCurr(MASCARA_MOEDA, RoundTo(aDuplicata.curValorPago, -2)),TAM_VALOR);
  Result := Msg;
end;

function TLiberacaoCreditos.fScriptGetDuplicata: String;
begin
  Result :=          ' SELECT  MOVGER.AUTOINCREM, CTR_CODEMP, CTR_CODCLI, CTR_NUMDUP, CTR_ESPDOC, CTR_PARCEL, ';
  Result := Result + '         SUM(CTR_VALREC) AS CTR_VALPGO, SUM(CTR_VALJUR) AS CTR_VALJUR, ';
  Result := Result + '         SUM(IF (((CTR_SEQBAI = 0 ) AND (CTR_VALREC = 0)),CTR_VALDUP, CTR_VALORI)) AS CTR_VALORI, CTR_VALDUP,	CTR_DTAVEN, CADCLI.CLI_NOMCLI ';

  Result := Result + ' FROM CADREC ';

  Result := Result + ' JOIN MOVGER ON CADREC.CTR_NUMDUP = MOVGER.GER_NUMDOC ';
  Result := Result + '                AND CADREC.CTR_ESPDOC = MOVGER.GER_ESPDOC ';
  Result := Result + '                AND MOVGER.GER_CODEMP = CADREC.CTR_CODEMP ';
  Result := Result + '                AND MOVGER.GER_CODCLI = CADREC.CTR_CODCLI ';

  Result := Result + ' JOIN CADCLI ON CADCLI.CLI_CODCLI = CADREC.CTR_CODCLI ';
  Result := Result + '                AND CADCLI.CLI_CODEMP = CADREC.CTR_CODEMP ';

  Result := Result + ' WHERE CADREC.CTR_NUMDUP = :NUMDUP AND CADREC.CTR_CODCLI = :CODCLI ';
  Result := Result + '       AND CADREC.CTR_CODEMP = :CODEMP AND CADREC.CTR_ESPDOC = :ESPDOC ';
  Result := Result + ' GROUP BY MOVGER.AUTOINCREM, CTR_CODEMP, CTR_CODCLI, CTR_NUMDUP, CTR_ESPDOC, CTR_PARCEL ';

  Result := Result + ' ORDER BY MOVGER.AUTOINCREM, CTR_CODEMP, CTR_CODCLI, CTR_NUMDUP, CTR_PARCEL, CADREC.AUTOINCREM ASC; ';
end;

function TLiberacaoCreditos.fScriptObterItensDevolucao: String;
begin
  Result :=          ' SELECT MOVDET.AUTOINCREM, MOVDET.DET_CODITE, ITE_DESITE, DET_TOTITE ';
  Result := Result + ' FROM MOVDET ';
  Result := Result + ' JOIN CADITE ON ITE_CODITE = DET_CODITE  AND ITE_CODEMP = DET_CODEMP ';
  Result := Result + ' WHERE MOVDET.DET_NUMDOC =  :NUMDOC ';
  Result := Result + '       AND MOVDET.DET_CODEMP = :CODEMP ';
  Result := Result + '       AND MOVDET.DET_ESPDOC = :ESPDOC ';
  Result := Result + '       AND MOVDET.DET_CODCLI = :CODCLI ';
end;

{ TItemGarantia }

procedure TItemGarantia.pSetstrNumDoc(const Value: String);
Var
  iPosicao: Integer;
begin
  FstrNumDocOriginal := Value;
  iPosicao := Pos('-', Value);
  if iPosicao > 0 then
  begin
    FstrNumDoc  := Copy(Value, 1, (iPosicao -1));
    FstrEspDoc  := Copy(Value, (iPosicao + 1), Length(Value));
  end
  else begin
    FstrNumDoc := Value;
  end;
end;

end.
