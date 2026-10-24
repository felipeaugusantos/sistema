unit untComboProdVenda;

interface

uses Windows, Classes, StrUtils, SysUtils, Controls, Uni, UniClientDataSet, UniDataSetProvider, DB,Graphics,
     EditFocus, Forms, Variants, StdCtrls, untFuncFat, untFuncoesSimples, Vcl.CheckLst, cxProgressBar, untTypesSistema;

Type
  TComVen = Class(TComponent)
    private
      qryGeneri: TUniQuery;
      qryComVen: TUniQuery;

      qryProAti: TUniQuery;
      dspProAti: TUniDataSetProvider;
      cdsProAti: TUniClientDataSet;

      qryProCom: TUniQuery;
      dspProCom: TUniDataSetProvider;
      cdsProCom: TUniClientDataSet;

      qryProSim: TUniQuery;
      dspProSim: TUniDataSetProvider;
      cdsProSim: TUniClientDataSet;

      cdsElemen: TUniClientDataSet;
      cdsEleGru: TUniClientDataSet;
      cdsEleMar: TUniClientDataSet;
      cdsEleFor: TUniClientDataSet;
      cdsEleGPr: TUniClientDataSet;
      cdsEleGPd: TUniClientDataSet;

      clbEmpresa: TCheckListBox;
      clbTabPre : TCheckListBox;

      strAutInc: String;
      strTabPre: String;

      tipTipPro: TTipProCombo;

      intDecQtd: Integer;
      intIncAti: Integer;
      intIncCom: Integer;
      blnFilCom: Boolean;
      blnFilSim: Boolean;

      dtaDtaIni: TDate;
      dtaDtaFin: TDate;

      strMsgCom: String;
      strEmpSel: String;

      arrDadEle: Array Of TDadEle;
      tipTipEle: TTipEle;
      oleBkpEle: OleVariant;

      //INICIO VARIÁVEIS DO FILTRO
      strCodIte: String;
      arrSelIte: TConsultasArray;
      strLinGru: String;
      arrSelLin: TConsultasArray;
      strCodMar: String;
      arrSelMar: TConsultasArray;
      strCodFor: String;
      arrSelFor: TConsultasArray;
      strDesIni: String;
      strDesFin: String;
      strRefere: String;
      strCodUni: String;
      arrSelUni: TConsultasArray;
      fltQtdIte: Double;
      blnAddPro: Boolean;
      blnAddPAt: Boolean;  // Indica se Adiciona o item para todos os Produtos de ativação
      strBrinde: String;
      strTabIte: String;
      strOperad: String;
      strTipDes: String;
      fltValDes: Double;
      // FIM VARIAVEIS DO FILTRO

      procedure pCarregaElementos;
      procedure pCriaComponentes;
      procedure pDestroiComponentes;
      procedure pCriaClientElementos;
      procedure pCarregaProdutosAtivacaoFiltro;
      procedure pCarregaProdutosComboFiltro;
      procedure pCarregaProdutosSimilaresFiltro;

      procedure pAfterOpen(DataSet: TDataSet);
      procedure pAfterScrollProAti(DataSet: TDataSet);
      procedure pAfterScrollProCom(DataSet: TDataSet);
      function  fApagaEmpresas(pgbProgresso: TcxProgressBar): Boolean;
      function  fRetSQLInsertEmpresa: String;
      function  fRetSQLInsertProdutoAtivacao: String;
      function  fRetSQLInsertProdutoCombo: String;
      function  fRetSQLInsertProdutoSimilar: String;
      function  fGravarInterna(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaEmpresas(pgbProgresso: TcxProgressBar): Boolean;
      function  fApagaProdutosAtivacao(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaProdutos(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaElementosIndicacao(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaElementos(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaElementoLinhaGrupo(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaElementoMarca(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaElementoFornecedor(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaElementoGrupoProduto(pgbProgresso: TcxProgressBar): Boolean;
      function  fGravaElementoGrupoPreco(pgbProgresso: TcxProgressBar): Boolean;
      function  fApagaElementos(pgbProgresso: TcxProgressBar): Boolean;
      function  fCarregaProdutosAtivacaoFiltro(pgbProgresso: TcxProgressBar): Boolean;
      function  fCarregaProdutosComboFiltro(pgbProgresso: TcxProgressBar): Boolean;
      function  fCarregaProdutosSimilaresFiltro(pgbProgresso: TcxProgressBar): Boolean;
      function  fRetSelectProdutosFiltro: String;
      function  fRetSQLFiltroLinhaGrupo: String;
      function  fTodosProdutosAtivacaoTemProdutoComboInterna(pgbProgresso: TcxProgressBar): Boolean;
      function  fProdutoJaEstaEmOutroCombo(strCodIte: String): Boolean;
      function  fValidaProdutoOutroComboVigenteInterna(pgbProgresso: TcxProgressBar): Boolean;
      function  fGetFiltroTabelaPrecoCombo(strTabTmp: String): String;
      function  fCarregaDadosAlteracao(pgbProgresso: TcxProgressBar): Boolean;
      function  fRetSQLElementoLinha: String;
      function  fRetSQLElementoMarca: String;
      function  fRetSQLElementoFornecedor: String;
      function  fRetSQLElementoGrupoPreco: String;
      function  fRetSQLElementoGrupoProduto: String;
      function  fExisteElementoLinhaGrupo: Boolean;
      function  fExisteElementoMarca: Boolean;
      function  fExisteElementoFornecedor: Boolean;
      function  fExisteElementoGrupoPreco: Boolean;
      function  fExisteElementoGrupoProduto: Boolean;

      procedure pSetaParametrosProdutosFiltro;
      procedure pFiltraProdutosCombo;
      procedure pFiltraProdutosSimilares;
      procedure pDeletaProdutoAtivacao;
      procedure pDeletaProdutoCombo;
      procedure pIncrementaAutIncProAtivacao;
      procedure pIncrementaAutIncProCombo;
      procedure pPreparaEmpresasSelecionadas;
      procedure pDefineTipoElemento;
      procedure pAbreTelaAjusteElemento;
      procedure pCarregaClientElementos;
      procedure pInsereElementosLinhaGrupo(qryElemen: TUniQuery);
      procedure pInsereElementosMarca(qryElemen: TUniQuery);
      procedure pInsereElementosFornecedor(qryElemen: TUniQuery);
      procedure pInsereElementosGrupoPrecos(qryElemen: TUniQuery);
      procedure pInsereElementosGrupoProdutos(qryElemen: TUniQuery);
      procedure pMarcaElementoExistente;
      procedure pAlteraDadosProduto;
      procedure pFazBackupDadosElemento;
      procedure pRestauraDadosElemento;

      function getCodIte: String;
      function getArrIte: TConsultasArray;
      function getLinGru: String;
      function getCodMar: String;
      function getArrMar: TConsultasArray;
      function getCodFor: String;
      function getArrFor: TConsultasArray;
      function getDesIni: String;
      function getDesFin: String;
      function getRefere: String;
      function getCodUni: String;
      function getArrUni: TConsultasArray;
      function getQtdIte: Double;
      function getAddPro: Boolean;
      function getAddPAt: Boolean;
      function getBrinde: String;
      function getTabIte: String;
      function getOperad: String;
      function getTipDes: String;
      function getValDes: Double;
      function getTipEle: TTipEle;
      Function getCdsEle: TUniClientDataSet;

      function getAutIncProAti: String;
      function getAutIncProCom: String;
      function getIncAti: Integer;
      function getIncCom: Integer;
      function getTodosAutIncProAti: String;
      function getTodosAutIncProCom: String;
      function getFilCom: Boolean;
      function getFilSim: Boolean;
      function getTabPre: String;
      function getDtaIni: TDate;
      function getDtaFin: TDate;
      function getMsgCom: String;
      function getEmpSel: String;

      procedure setCodIte(Value: String);
      procedure setArrIte(Value: TConsultasArray);
      procedure setLinGru(Value: String);
      procedure setArrGru(Value: TConsultasArray);
      procedure setCodMar(Value: String);
      procedure setArrMar(Value: TConsultasArray);
      procedure setCodFor(Value: String);
      procedure setArrFor(Value: TConsultasArray);
      procedure setDesIni(Value: String);
      procedure setDesFin(Value: String);
      procedure setRefere(Value: String);
      procedure setCodUni(Value: String);
      procedure setArrUni(Value: TConsultasArray);
      procedure setQtdIte(Value: Double);
      procedure setAddPro(Value: Boolean);
      procedure setAddPAt(Value: Boolean);
      procedure setBrinde(Value: String);
      procedure setTabIte(Value: String);
      procedure setOperad(Value: String);
      procedure setTipDes(Value: String);
      procedure setValDes(Value: Double);
      procedure setFilCom(Value: Boolean);
      procedure setFilSim(Value: Boolean);
      procedure setMsgCom(Value: String);
      procedure setEmpSel(Value: String);
      procedure setTipEle(Value: TTipEle);

    public
      qryHeranc: TUniQuery;

      function  getQueryComVen: TUniQuery;
      function  getAutInc   : String;
      function  getTipPro   : TTipProCombo;
      function  getCdsProAti: TUniClientDataSet;
      function  getCdsProCom: TUniClientDataSet;
      function  getCdsProSim: TUniClientDataSet;
      function  getCdsElemen: TUniClientDataSet;

      procedure setEmpresas(Value: TCheckListBox);
      procedure setTabPre(Value: TCheckListBox); overload;
      procedure setTabPre(Value: String); overload;
      procedure setAutInc(Value: String);
      procedure setTipPro(Value: TTipProCombo);
      procedure setIncAti(Value: Integer);
      procedure setIncCom(Value: Integer);
      procedure setDtaIni(Value: TDate);
      procedure setDtaFin(Value: TDate);

      procedure pCarregaEmpresas;
      procedure pMarcaSelecaoEmpresas;
      procedure pMarcaSelecaoTabelaPreco;
      procedure pDesmarcaTodasTabelasPrecos;
      procedure pMarcaTodasTabelasPrecos;
      procedure pDesmarcaTabelaPrecoNaoUtilizada;
      procedure pValorDeFault;
      procedure pCarregaDadosAlteracao;
      procedure pCarregaProdutosAtivacao;
      procedure pCarregaProdutosCombo;
      procedure pCarregaProdutosSimilares;
      procedure pApagaRegistro;

      function  fAbreFiltroProduto: Boolean;
      function  fSelecionouEmpresa: Boolean;
      function  fRetornaTabelasSelecionadas(clbTabPre: TCheckListBox): String;
      function  fGravar: Boolean;
      function  fExisteProdutosAtivacao: Boolean;
      function  fExisteProdutosCombo: Boolean;
      function  fExisteProdutosSimilares: Boolean;
      function  fTodosProdutosAtivacaoTemProdutoCombo: Boolean;
      function  fHerdarCombo: Boolean;
      function  fValidaProdutoOutroComboVigente: Boolean;

      procedure pMostraProdutosJaExistentesOutroCombo;
      procedure pMarcaTodasEmpresas;
      procedure pDesmarcaTodasEmpresas;

      procedure pAlterarDadosProdutoAtivacao;
      procedure pAlterarDadosProdutoCombo;
      procedure pAjustaElementos;

      Constructor Create(Owner: TComponent); override;
      Destructor  Destroy; override;
End;


implementation

{ TComVen }

uses untFiltrosProdutos, untObservacao, untAlteraProdCombo, untCadElemCombo,
  untHerancaCombo, untFuncoesConsulta, untGravando;

constructor TComVen.Create(Owner: TComponent);
begin
  inherited create(Owner);
  pCarregaElementos;
  pCriaComponentes;
  intDecQtd := fCfgSis('DECQTD', VarInteger);
  setIncAti(1);
  setIncCom(1);
  setFilCom(True);
  setFilSim(True);
  setMsgCom('');
end;

procedure TComVen.pDefineTipoElemento;
begin
  If (cdsElemen.FieldByName('CODELE').AsString = 'ELEMAR') Then
    setTipEle(telMarca)
  Else If (cdsElemen.FieldByName('CODELE').AsString = 'ELEGRU') Then
    setTipEle(telLinhaGrupo)
  Else If (cdsElemen.FieldByName('CODELE').AsString = 'ELEFOR') Then
    setTipEle(telFornecedor)
  Else If (cdsElemen.FieldByName('CODELE').AsString = 'ELEGPR') Then
    setTipEle(telGrupoPreco)
  Else If (cdsElemen.FieldByName('CODELE').AsString = 'ELEGPD') Then
    setTipEle(telGrupoProd);
end;

procedure TComVen.pDeletaProdutoAtivacao;
begin
  If (fExisteProdutosCombo) Then
  Begin
    With cdsProCom Do
    Begin
      First;
      While Not Eof Do
      Begin
        Delete;
      End;
    End;
  End;

  If (fExisteProdutosSimilares) Then
  Begin
    With cdsProSim Do
    Begin
      First;
      While Not Eof Do
      Begin
        Delete;
      End;
    End;
  End;

  cdsProAti.Delete;
end;

procedure TComVen.pDeletaProdutoCombo;
begin
  If (fExisteProdutosSimilares) Then
  Begin
    With cdsProSim Do
    Begin

      First;
      While Not Eof Do
      Begin
        Delete;
      End;
    End;
  End;

  cdsProCom.Delete;
end;

procedure TComVen.pDesmarcaTodasEmpresas;
Var
  intContador: Integer;
begin
  For intContador := 0 To clbEmpresa.Items.Count - 1 Do
  Begin
    clbEmpresa.Checked[intContador] := False;
  End;
end;

procedure TComVen.pDesmarcaTabelaPrecoNaoUtilizada;
Var
  intContador: Integer;
begin
  For intContador := 1 To clbTabPre.Items.Count Do
  Begin
    If VS_strTabVen[intContador] <> 'S' Then
      clbTabPre.Checked[Pred(intContador)] := False;
  End;
end;

procedure TComVen.pDesmarcaTodasTabelasPrecos;
Var
  intContador: Integer;
begin
  For intContador := 0 To clbTabPre.Items.Count -1 Do
  Begin
    clbTabPre.Checked[intContador] := False;
  End;
end;

destructor TComVen.Destroy;
begin
  pDestroiComponentes;
  inherited destroy;
end;

function TComVen.fApagaElementos(pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
  intContador: Integer;
begin

  Result := False;

  Try

    For intContador := 0 To Length(arrDadEle) - 1 Do
    Begin
      pInfoStatusGravacao(pgbProgresso, 'Aguarde... Apagando Elementos de Indicação: ' + IntToStr(intContador + 1) + '/' + intToStr(Length(arrDadEle)));

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM           ';
      strSQL := strSQL +    arrDadEle[intContador].strCodEle + ' ';
      strSQL := strSQL + 'WHERE                  ';
      strSQL := strSQL + '  ELE_SEQGER = :SEQGER ';

      With qryGeneri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQGER').AsString := getAutInc;
        ExecSQL;
      End;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fApagaElementos]');
  End;

end;

function TComVen.fApagaEmpresas(pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Apagando Empresas do Combo...');

  Try

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  COMEMP    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  COM_SEQGER = :SEQGER ';

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := getAutInc;
      ExecSQL;
      Result := True;
      pStepStatusGravacao(pgbProgresso);
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fApagaEmpresas]')
  End;

end;

function TComVen.fApagaProdutosAtivacao(pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Apagando Produtos de Ativação...');

  Try

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  PROATI    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  ATI_SEQGER = :SEQGER ';

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := getAutInc;
      ExecSQL;
      Result := True;
      pStepStatusGravacao(pgbProgresso);
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fApagaEmpresas]')
  End;

end;

function TComVen.fCarregaDadosAlteracao(pgbProgresso: TcxProgressBar): Boolean;
begin
  pgbProgresso.Properties.Max := 6;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Selecionando as Empresas...');
  pMarcaSelecaoEmpresas;
  pStepStatusGravacao(pgbProgresso);

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Selecionando as Tabelas de Preços...');
  pMarcaSelecaoTabelaPreco;
  pStepStatusGravacao(pgbProgresso);

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando Produtos de Ativação...');
  pCarregaProdutosAtivacao;
  pStepStatusGravacao(pgbProgresso);

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando Produtos do Combo...');
  pCarregaProdutosCombo;
  pStepStatusGravacao(pgbProgresso);

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando Produtos Similares...');
  pCarregaProdutosSimilares;
  pStepStatusGravacao(pgbProgresso);

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando Elementos de Indicação na Venda...');
  pCarregaClientElementos;
  pStepStatusGravacao(pgbProgresso);

  Result := True;
end;

function TComVen.fCarregaProdutosAtivacaoFiltro(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin
  Result := False;

  Try

    pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando Produtos de Ativação...');

    strSQL := fRetSelectProdutosFiltro;

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParametrosProdutosFiltro;
      Open;
      First;

      If (IsEmpty) Then
        fMensagem('ATENÇÃO!', 'Nenhum Produto encontrado para os filtros informados!', ['&O k'])
      Else
      Begin
        pgbProgresso.Properties.Max := RecordCount;
        cdsProAti.DisableControls;

        If (Not getAddPro) Then
        Begin
          cdsProAti.EmptyDataSet;
          cdsProCom.EmptyDataSet;
          cdsProSim.EmptyDataSet;
        End;

        setFilCom(False);
        pPreparaEmpresasSelecionadas;

        While Not Eof Do
        Begin
          pInfoStatusGravacao(pgbProgresso, 'Aguarde... Inserindo Produtos: ' + #13#10 + FieldByName('CODITE').AsString + '-' + Copy(FieldByName('DESITE').AsString, 1, 15));

          fProdutoJaEstaEmOutroCombo(FieldByName('CODITE').AsString);

          If (cdsProAti.Locate('CODITEA', FieldByName('CODITE').AsString, [])) Then
            cdsProAti.Edit
          Else
          Begin
            cdsProAti.Append;
            cdsProAti.FieldByName('AUTINCA').AsString := IntToStr(getIncAti);
            cdsProAti.FieldByName('CODITEA').AsString := FieldByName('CODITE').AsString;
            cdsProAti.FieldByName('DESITEA').AsString := FieldByName('DESITE').AsString;
            cdsProAti.FieldByName('REFEREA').AsString := FieldByName('REFERE').AsString;
            cdsProAti.FieldByName('SIGUNIA').AsString := FieldByName('SIGUNI').AsString;
            pIncrementaAutIncProAtivacao;
          End;

          cdsProAti.FieldByName('QTDITEA').AsFloat  := getQtdIte;
          cdsProAti.Post;

          pStepStatusGravacao(pgbProgresso);
          Next;
        End;

        cdsProAti.First;
        cdsProAti.EnableControls;
        setFilCom(True);
        pFiltraProdutosCombo;
      End;

      Result := True;

    End;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[fCarregaProdutosAtivacaoFiltro]');
  End;

end;

function TComVen.fCarregaProdutosComboFiltro(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL,
  CodItemAti: String;

begin
  Result := False;

  Try

    pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando Produtos do Combo...');

    strSQL := fRetSelectProdutosFiltro;

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParametrosProdutosFiltro;
      Open;
      First;

      If (IsEmpty) Then
        fMensagem('ATENÇÃO!', 'Nenhum Produto encontrado para os filtros informados!', ['&O k'])
      Else
      Begin
        pgbProgresso.Properties.Max := RecordCount;

        cdsProCom.DisableControls;

        If (Not getAddPro) Then
        Begin
          cdsProCom.EmptyDataSet;
          cdsProSim.EmptyDataSet;
        End;

        SetFilSim(False);

        if getAddPAt then
        begin
          CodItemAti := cdsProAti.FieldByName('CODITEA').AsString;
          cdsProAti.DisableControls;
          cdsProAti.First;
        end;

        While Not cdsProAti.Eof Do
        Begin
          First;
          While Not Eof Do
          Begin
            pInfoStatusGravacao(pgbProgresso, 'Aguarde... Inserindo Produtos: ' + #13#10 + FieldByName('CODITE').AsString + '-' + Copy(FieldByName('DESITE').AsString, 1, 15));

            If (cdsProCom.Locate('CODITEC', FieldByName('CODITE').AsString, [])) Then
              cdsProCom.Edit
            Else
            Begin
              cdsProCom.Append;
              cdsProCom.FieldByName('AUTINCC').AsString := IntToStr(getIncCom);
              pIncrementaAutIncProCombo;
            End;

            cdsProCom.FieldByName('SEQGERC').AsString := getAutIncProAti;
            cdsProCom.FieldByName('CODITEC').AsString := FieldByName('CODITE').AsString;
            cdsProCom.FieldByName('DESITEC').AsString := FieldByName('DESITE').AsString;
            cdsProCom.FieldByName('REFEREC').AsString := FieldByName('REFERE').AsString;
            cdsProCom.FieldByName('SIGUNIC').AsString := FieldByName('SIGUNI').AsString;
            cdsProCom.FieldByName('QTDITEC').AsFloat  := getQtdIte;
            cdsProCom.FieldByName('BRINDEC').AsString := getBrinde;
            cdsProCom.FieldByName('TABPREC').AsString := getTabIte;
            cdsProCom.FieldByName('OPERADC').AsString := getOperad;
            cdsProCom.FieldByName('TIPDESC').AsString := getTipDes;
            cdsProCom.FieldByName('VALDESC').AsFloat  := getValDes;
            cdsProCom.Post;

            pStepStatusGravacao(pgbProgresso);
            Next;
          End;
          if getAddPat then
            cdsProAti.next
          else break;
        End;
        if getAddPAt then
        begin
          cdsProAti.Locate('CODITEA', CodItemAti, []);
          cdsProAti.EnableControls;
        end;

        cdsProCom.First;
        cdsProCom.EnableControls;
        setFilSim(True);
        pFiltraProdutosSimilares;
      End;

      Result := True;
    End;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[fCarregaProdutosComboFiltro]');
  End;

end;

function TComVen.fCarregaProdutosSimilaresFiltro(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL,
  CodItemAti, CodItemCombo : String;

begin
  Result := False;

  Try

    pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando Produtos Similares do Combo...');

    strSQL := fRetSelectProdutosFiltro;

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParametrosProdutosFiltro;
      Open;
      First;

      If (IsEmpty) Then
        fMensagem('ATENÇÃO!', 'Nenhum Produto encontrado para os filtros informados!', ['&O k'])
      Else
      Begin
        pgbProgresso.Properties.Max := RecordCount;
        cdsProSim.DisableControls;

        If (Not getAddPro) Then
          cdsProSim.EmptyDataSet;

        CodItemAti   := cdsProAti.FieldByName('CODITEA').AsString;
        CodItemCombo := cdsProCom.FieldByName('CODITEC').AsString;
        if getAddPAt then
        begin
          cdsProAti.DisableControls;
          cdsProAti.First;
          cdsProCom.DisableControls;
        end;

        While Not cdsProAti.Eof Do
        Begin
          If (cdsProCom.Locate('CODITEC', CodItemCombo, [])) Then
          Begin
            First;
            While Not Eof Do
            Begin
              pInfoStatusGravacao(pgbProgresso, 'Aguarde... Inserindo Produtos: ' + #13#10 + FieldByName('CODITE').AsString + '-' + Copy(FieldByName('DESITE').AsString, 1, 15));

              If (cdsProSim.Locate('CODITES', FieldByName('CODITE').AsString, [])) Then
                cdsProSim.Edit
              Else
                cdsProSim.Append;

              cdsProSim.FieldByName('SEQGERS').AsString := getAutIncProCom;
              cdsProSim.FieldByName('CODITES').AsString := FieldByName('CODITE').AsString;
              cdsProSim.FieldByName('DESITES').AsString := FieldByName('DESITE').AsString;
              cdsProSim.FieldByName('REFERES').AsString := FieldByName('REFERE').AsString;
              cdsProSim.FieldByName('SIGUNIS').AsString := FieldByName('SIGUNI').AsString;
              cdsProSim.Post;

              pStepStatusGravacao(pgbProgresso);
              Next;
            End;
          End;
          if getAddPat then
            cdsProAti.next
          else break;
        End;
        if getAddPAt then
        begin
          cdsProAti.Locate('CODITEA', CodItemAti, []);
          cdsProAti.EnableControls;
          cdsProCom.Locate('CODITEC', CodItemCombo, []);
          cdsProCom.EnableControls;
        end;
        cdsProSim.First;
        cdsProSim.EnableControls;
      End;

      Result := True;

    End;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[fCarregaProdutosSimilaresFiltro]');
  End;

end;

function TComVen.fExisteElementoFornecedor: Boolean;
begin
  Result := (Not cdsEleFor.IsEmpty);
end;

function TComVen.fExisteElementoGrupoPreco: Boolean;
begin
  Result := (Not cdsEleGPr.IsEmpty);
end;

function TComVen.fExisteElementoGrupoProduto: Boolean;
begin
  Result := (Not cdsEleGPd.IsEmpty);
end;

function TComVen.fExisteElementoLinhaGrupo: Boolean;
begin
  Result := (Not cdsEleGru.IsEmpty);
end;

function TComVen.fExisteElementoMarca: Boolean;
begin
  Result := (Not cdsEleMar.IsEmpty);
end;

function TComVen.fExisteProdutosAtivacao: Boolean;
begin
  Result := (Not cdsProAti.IsEmpty);
end;

function TComVen.fExisteProdutosCombo: Boolean;
begin
  Result := (Not cdsProCom.IsEmpty);
end;

function TComVen.fExisteProdutosSimilares: Boolean;
begin
  Result := (Not cdsProSim.IsEmpty);
end;

function TComVen.fGetFiltroTabelaPrecoCombo(strTabTmp: String): String;
  Var
    intTab: Integer;
begin
  Result := '';

  //Combo da tabela de preco informada ou que nao estejam vinculadas a nenhuma tabela de preco
  If Not fEmptyStr(strTabTmp) Then
  Begin
    //Caso veio por parametro o numero da tabela de preco
    If CharInSet(strTabTmp[1], ['1'..'7']) Then
    Begin
      Result := ' AND MID(COM_TABPRE, ' +  strTabTmp + ', 1) = "S" '; //Exemplo: tabela 3 "NNSNNNN"
    End
    //caso veio por exemplo 'NNSNNSS' (Usa as tabelas 3, 6 e 7)
    Else If Pos('S', strTabTmp) > 0 Then
    Begin
      For intTab := 1 To Length(strTabTmp) Do
      Begin
        If strTabTmp[intTab] = 'S' Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ' OR ';
          Result := Result + ' (MID(COM_TABPRE, ' +  intToStr(intTab) + ', 1) = "S") '; //Exemplo: Tabela 3 "NNSNNNN"
        End;
      End;
      Result := ' AND ( ' + Result + ' ) ';
    End;
  End;
end;

function TComVen.fGravaElementoFornecedor(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde...Gravando Elemento de Indicação Fornecedor...');

  Try

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO          ';
    strSQL := strSQL + '  ELEFOR(AUTOINCREM, ';
    strSQL := strSQL + '         ELE_SEQGER, ';
    strSQL := strSQL + '         ELE_CODFOR) ';
    strSQL := strSQL + '  VALUES(:AUTINC,    ';
    strSQL := strSQL + '         :SEQGER,    ';
    strSQL := strSQL + '         :CODFOR)    ';

    cdsEleFor.First;

    While Not cdsEleFor.Eof Do
    Begin
      With qryGeneri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := fRetAutoIncrem('ELEFOR', VS_strCodEmp);
        ParamByName('SEQGER').AsString := getAutInc;
        ParamByName('CODFOR').AsString := cdsEleFor.FieldByName('CODIGO').AsString;
        ExecSQL;
      End;

      cdsEleFor.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaElementoFornecedor]');
  End;
end;

function TComVen.fGravaElementoGrupoPreco(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde...Gravando Elemento de Indicação Grupo de Preço...');

  Try

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO          ';
    strSQL := strSQL + '  ELEGPR(AUTOINCREM, ';
    strSQL := strSQL + '         ELE_SEQGER, ';
    strSQL := strSQL + '         ELE_CODGPR) ';
    strSQL := strSQL + '  VALUES(:AUTINC,    ';
    strSQL := strSQL + '         :SEQGER,    ';
    strSQL := strSQL + '         :CODGPR)    ';

    cdsEleGPr.First;

    While Not cdsEleGPr.Eof Do
    Begin
      With qryGeneri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := fRetAutoIncrem('ELEGPR', VS_strCodEmp);
        ParamByName('SEQGER').AsString := getAutInc;
        ParamByName('CODGPR').AsString := cdsEleGPr.FieldByName('CODIGO').AsString;
        ExecSQL;
      End;

      cdsEleGPr.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaElementoGrupoPreco]');
  End;

end;

function TComVen.fGravaElementoGrupoProduto(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde...Gravando Elemento de Indicação Grupo de Produto...');

  Try

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO          ';
    strSQL := strSQL + '  ELEGPD(AUTOINCREM, ';
    strSQL := strSQL + '         ELE_SEQGER, ';
    strSQL := strSQL + '         ELE_CODGPD) ';
    strSQL := strSQL + '  VALUES(:AUTINC,    ';
    strSQL := strSQL + '         :SEQGER,    ';
    strSQL := strSQL + '         :CODGPD)    ';

    cdsEleGPd.First;

    While Not cdsEleGPd.Eof Do
    Begin
      With qryGeneri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := fRetAutoIncrem('ELEGPD', VS_strCodEmp);
        ParamByName('SEQGER').AsString := getAutInc;
        ParamByName('CODGPD').AsString := cdsEleGPd.FieldByName('CODIGO').AsString;
        ExecSQL;
      End;

      cdsEleGPd.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaElementoGrupoProduto]');
  End;

end;

function TComVen.fGravaElementoLinhaGrupo(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde...Gravando Elemento de Indicação Linha/Grupo...');

  Try

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO          ';
    strSQL := strSQL + '  ELEGRU(AUTOINCREM, ';
    strSQL := strSQL + '         ELE_SEQGER, ';
    strSQL := strSQL + '         ELE_CODGRU) ';
    strSQL := strSQL + '  VALUES(:AUTINC,    ';
    strSQL := strSQL + '         :SEQGER,    ';
    strSQL := strSQL + '         :CODGRU)    ';

    cdsEleGru.First;

    While Not cdsEleGru.Eof Do
    Begin
      With qryGeneri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := fRetAutoIncrem('ELEGRU', VS_strCodEmp);
        ParamByName('SEQGER').AsString := getAutInc;
        ParamByName('CODGRU').AsString := cdsEleGru.FieldByName('CODIGO').AsString;
        ExecSQL;
      End;

      cdsEleGru.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaElementoLinhaGrupo]');
  End;

end;

function TComVen.fGravaElementoMarca(pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde...Gravando Elemento de Indicação Marca...');

  Try

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO          ';
    strSQL := strSQL + '  ELEMAR(AUTOINCREM, ';
    strSQL := strSQL + '         ELE_SEQGER, ';
    strSQL := strSQL + '         ELE_CODMAR) ';
    strSQL := strSQL + '  VALUES(:AUTINC,    ';
    strSQL := strSQL + '         :SEQGER,    ';
    strSQL := strSQL + '         :CODMAR)    ';

    cdsEleMar.First;

    While Not cdsEleMar.Eof Do
    Begin
      With qryGeneri Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := fRetAutoIncrem('ELEMAR', VS_strCodEmp);
        ParamByName('SEQGER').AsString := getAutInc;
        ParamByName('CODMAR').AsString := cdsEleMar.FieldByName('CODIGO').AsString;
        ExecSQL;
      End;

      cdsEleMar.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaElementoMarca]');
  End;

end;

function TComVen.fGravaElementos(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fGravaElementoLinhaGrupo(pgbProgresso);
  Result := Result And fGravaElementoMarca(pgbProgresso);
  Result := Result And fGravaElementoFornecedor(pgbProgresso);
  Result := Result And fGravaElementoGrupoProduto(pgbProgresso);
  Result := Result And fGravaElementoGrupoPreco(pgbProgresso);
end;

function TComVen.fGravaElementosIndicacao(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;

  Try
    Result := fApagaElementos(pgbProgresso);
    Result := Result And fGravaElementos(pgbProgresso);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaElementosIndicacao]');
  End;
end;

function TComVen.fGravaEmpresas(pgbProgresso: TcxProgressBar): Boolean;
Var
  intContador: Integer;
  strSQL     : String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Gravando Empresas do Combo...');

  Try
    strSQL := fRetSQLInsertEmpresa;

    For intContador := 0 To clbEmpresa.Items.Count - 1 Do
    Begin
      If (clbEmpresa.Checked[intContador]) Then
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Inserindo Empresas ' + Copy(clbEmpresa.Items[intContador],1, 15));

        With qryGeneri Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('AUTINC').AsString := fRetAutoIncrem('COMEMP', VS_strCodEmp);
          ParamByName('SEQGER').AsString := getAutInc;
          ParamByName('CODEMP').AsString := LeftStr(clbEmpresa.Items[intContador], 3);
          ExecSQL;
        End;
      End;
    End;

    pStepStatusGravacao(pgbProgresso);
    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaEmpresas]');
  End;

end;

function TComVen.fGravaProdutos(pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQLAti: String;
  strSQLCom: String;
  strSQLSim: String;
  strIncAti: String;
  strIncCom: String;
begin

  Result := False;

  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Gravando Produtos de Ativação de Venda...');

  Try
    Result := fApagaProdutosAtivacao(pgbProgresso);

    If (Result) Then
    Begin
      Result := False;
      strSQLAti := fRetSQLInsertProdutoAtivacao;
      strSQLCom := fRetSQLInsertProdutoCombo;
      strSQLSim := fRetSQLInsertProdutoSimilar;

      cdsProAti.DisableControls;
      cdsProCom.DisableControls;
      cdsProSim.DisableControls;

      setFilCom(True);
      setFilSim(True);

      With cdsProAti Do
      Begin
        First;

        While Not Eof Do
        Begin
          pInfoStatusGravacao(pgbProgresso, 'Aguarde... Gravando Produto de Ativação: ' + intToStr(RecNo) + '/' +  intToStr(RecordCount) + #13#10 + FieldByName('CODITEA').AsString + '-' + Copy(FieldByName('DESITEA').AsString ,1, 15));

          With qryGeneri Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQLAti);

            strIncAti := fRetAutoIncrem('PROATI', VS_strCodEmp);

            ParamByName('AUTOIN').AsString := strIncAti;
            ParamByName('SEQGER').AsString := getAutInc;
            ParamByName('CODITE').AsString := cdsProAti.FieldByName('CODITEA').AsString;
            ParamByName('QTDITE').AsFloat  := cdsProAti.FieldByName('QTDITEA').AsFloat;
            ExecSQL;

            cdsProCom.First;

            While Not cdsProCom.Eof Do
            Begin
              pInfoStatusGravacao(pgbProgresso, 'Aguarde... Gravando Produto do Combo: ' + intToStr(cdsProCom.RecNo) + '/' +  intToStr(cdsProCom.RecordCount) + #13#10 + cdsProCom.FieldByName('CODITEC').AsString + '-' + Copy(cdsProCom.FieldByName('DESITEC').AsString ,1, 15));
              Close;
              SQL.Clear;
              SQL.Add(strSQLCom);

              strIncCom := fRetAutoIncrem('PROCOM', VS_strCodEmp);

              ParamByName('AUTOIN').AsString := strIncCom;
              ParamByName('SEQGER').AsString := strIncAti;
              ParamByName('CODITE').AsString := cdsProCom.FieldByName('CODITEC').AsString;
              ParamByName('QTDITE').AsFloat  := cdsProCom.FieldByName('QTDITEC').AsFloat;
              ParamByName('BRINDE').AsString := cdsProCom.FieldByName('BRINDEC').AsString;
              ParamByName('TABPRE').AsString := cdsProCom.FieldByName('TABPREC').AsString;
              ParamByName('OPERAD').AsString := cdsProCom.FieldByName('OPERADC').AsString;
              ParamByName('TIPDES').AsString := cdsProCom.FieldByName('TIPDESC').AsString;
              ParamByName('VALDES').AsFloat  := cdsProCom.FieldByName('VALDESC').AsFloat;
              ExecSQL;

              cdsProSim.First;

              While Not cdsProSim.Eof Do
              Begin
                pInfoStatusGravacao(pgbProgresso, 'Aguarde... Gravando Produto Similar do Combo: ' + intToStr(cdsProSim.RecNo) + '/' +  intToStr(cdsProSim.RecordCount) + #13#10 + cdsProSim.FieldByName('CODITES').AsString + '-' + Copy(cdsProSim.FieldByName('DESITES').AsString ,1, 15));
                Close;
                SQL.Clear;
                SQL.Add(strSQLSim);
                ParamByName('AUTOIN').AsString := fRetAutoIncrem('PROSIM', VS_strCodEmp);
                ParamByName('SEQGER').AsString := strIncCom;
                ParamByName('CODITE').AsString := cdsProSim.FieldByName('CODITES').AsString;
                ExecSQL;
                cdsProSim.Next;
              End;

              cdsProCom.Next;
            End;

          End;

          pStepStatusGravacao(pgbProgresso);

          Next;
        End;
      End;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fGravaEmpresas]');
  End;

  cdsProAti.First;
  cdsProAti.EnableControls;
  cdsProCom.EnableControls;
  cdsProSim.EnableControls;

  setFilCom(True);
  setFilSim(True);

  pFiltraProdutosCombo;
  pFiltraProdutosSimilares;
end;

function TComVen.fGravar: Boolean;
begin
  Result := fChamaTelaGravando(fGravarInterna);
end;

function TComVen.fGravarInterna(pgbProgresso: TcxProgressBar): Boolean;
begin
  pgbProgresso.Properties.Max := 2;
  Result := fApagaEmpresas(pgbProgresso);
  Result := Result And fGravaEmpresas(pgbProgresso);
  Result := Result And fGravaProdutos(pgbProgresso);
  Result := Result And fGravaElementosIndicacao(pgbProgresso);
end;

function TComVen.fHerdarCombo: Boolean;
begin
  Result := False;

  Try

    pCriarFormularios(TfrmHerancaCombo, frmHerancaCombo);
    frmHerancaCombo.qryGenCom := qryHeranc;
    frmHerancaCombo.ShowModal;

    Result := frmHerancaCombo.blnConfirma;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fHerdarCombo]');
  End;

  pFreeAndNil(frmHerancaCombo);

end;

function TComVen.fProdutoJaEstaEmOutroCombo(strCodIte: String): Boolean;
Var
  strSQL   : String;
  qryCom   : TUniQuery;
  strTabTmp: String;
  stlMsgTmp: TStringList;
begin

  Result := False;

  Try

    qryCom    := fCriaQuery(Nil);
    stlMsgTmp := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  C.COM_CODCOM,     ';
    strSQL := strSQL + '  C.COM_DESCOM,     ';
    strSQL := strSQL + '  C.COM_DTAINI,     ';
    strSQL := strSQL + '  C.COM_DTAFIN,     ';
    strSQL := strSQL + '  I.ITE_CODITE,     ';
    strSQL := strSQL + '  I.ITE_DESITE,     ';
    strSQL := strSQL + '  E.COM_CODEMP,     ';
    strSQL := strSQL + '  GROUP_CONCAT(E.COM_CODEMP, ", ") AS EMPRES          ';
    strSQL := strSQL + 'FROM                ';
    strSQL := strSQL + '  PROATI A          ';
    strSQL := strSQL + '  INNER JOIN COMVEN C ON C.AUTOINCREM = A.ATI_SEQGER  ';
    strSQL := strSQL + '  INNER JOIN COMEMP E ON E.COM_SEQGER = C.AUTOINCREM  ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = A.ATI_CODITE  ';
    strSQL := strSQL + 'WHERE                                                 ';
    strSQL := strSQL + '  A.ATI_SEQGER <> :SEQGER       AND                   ';
    strSQL := strSQL + '  A.ATI_CODITE =  :CODITE       AND                   ';
    strSQL := strSQL + '  (:DTAINI BETWEEN COM_DTAINI AND COM_DTAFIN OR       ';
    strSQL := strSQL + '   :DTAFIN BETWEEN COM_DTAINI AND COM_DTAFIN) AND     ';
    strSQL := strSQL + '  LOCATE(E.COM_CODEMP, :EMPSEL) > 0                   ';

    strTabTmp := getTabPre;
    strSQL := strSQL + fGetFiltroTabelaPrecoCombo(strTabTmp);

    strSQL := strSQL + 'GROUP BY      ';
    strSQL := strSQL + '  COM_CODCOM  ';
    strSQL := strSQL + 'ORDER BY      ';
    strSQL := strSQL + '  COM_CODCOM, ';
    strSQL := strSQL + '  COM_CODEMP ';

    With qryCom Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := getAutInc;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('DTAINI').AsDate   := getDtaIni;
      ParamByName('DTAFIN').AsDate   := getDtaFin;
      ParamByName('EMPSEL').AsString := getEmpSel;

      Open;
      First;

      setMsgCom('');
      stlMsgTmp.Clear;

      If (Not IsEmpty) Then
      Begin
        Result := True;

        While Not Eof Do
        Begin
          stlMsgTmp.Add('---------------------------------------------------------------------------------------------------');
          stlMsgTmp.Add('Produto.: ' + FieldByName('ITE_CODITE').AsString + '-' + Copy(FieldByName('ITE_DESITE').AsString, 1, 40));
          stlMsgTmp.Add('Combo...: ' + FieldByName('COM_CODCOM').AsString + '-' + FieldByName('COM_DESCOM').AsString);
          stlMsgTmp.Add('Empresas: ' + FieldByName('EMPRES').AsString);
          stlMsgTmp.Add('Validade: ' + FormatDateTime('DD/MM/YYYY', FieldByName('COM_DTAINI').AsDateTime) + ' a ' + FormatDateTime('DD/MM/YYYY', FieldByName('COM_DTAFIN').AsDateTime));
          Next;
        End;

        setMsgCom(stlMsgTmp.Text);
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fProdutoJaEstaEmOutroCombo]');
  End;

  FreeAndNil(qryCom);
  FreeAndNil(stlMsgTmp);

end;

function TComVen.fRetornaTabelasSelecionadas(clbTabPre: TCheckListBox): String;
Var
  intContador: Integer;
begin
  Result := '';
  For intContador := 0 To clbTabPre.Items.Count -1 Do
    Result := Result + IfThen(clbTabPre.Checked[intContador], 'S', 'N');
end;

function TComVen.fRetSelectProdutosFiltro: String;
begin
  Result := '';
  Result := Result + 'SELECT                                            ';
  Result := Result + '  ITE_CODITE AS CODITE,                           ';
  Result := Result + '  ITE_DESITE AS DESITE,                           ';
  Result := Result + '  ITE_REFERE AS REFERE,                           ';
  Result := Result + '  UNI_SIGUNI AS SIGUNI                            ';
  Result := Result + 'FROM                                              ';
  Result := Result + '  CADITE                                          ';
  Result := Result + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI    ';
  Result := Result + 'WHERE                                             ';
  Result := Result + '  ITE_ITEATI = "S"                                ';

  Result := Result + fStrLocate(Nil, getArrIte,'ITE_CODITE','CODITE', False, False, getCodIte);
  Result := Result + fRetSQLFiltroLinhaGrupo;
  Result := Result + fStrLocate(Nil, getArrFor,'ITE_CODFOR','CODFOR', False, False, getCodFor);
  Result := Result + fStrLocate(Nil, getArrMar,'ITE_CODMAR','CODMAR', False, False, getCodMar);
  Result := Result + fStrLocate(Nil, getArrUni,'ITE_CODUNI','CODUNI', False, False, getCodUni);

  If (Not fEmptyStr(getDesIni)) and (Not fEmptyStr(getDesFin)) Then
    Result := Result + '  AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ';

  If (Not fEmptyStr(getRefere)) Then
    Result := Result + '  AND ITE_REFERE = :REFERE ';

  Result := Result + ' ORDER BY ITE_DESITE ';

end;

function TComVen.fRetSQLElementoFornecedor: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE    ';
  Result := Result + '  ELE_CODFOR,          ';
  Result := Result + '  FOR_NOMFOR           ';
  Result := Result + 'FROM                   ';
  Result := Result + '  ELEFOR               ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = ELE_CODFOR ';
  Result := Result + 'WHERE                  ';
  Result := Result + '  ELE_SEQGER = :SEQGER ';
end;

function TComVen.fRetSQLElementoGrupoPreco: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE    ';
  Result := Result + '  ELE_CODGPR,          ';
  Result := Result + '  GPR_DESCRI           ';
  Result := Result + 'FROM                   ';
  Result := Result + '  ELEGPR               ';
  Result := Result + '  LEFT JOIN CADGPR ON GPR_CODIGO = ELE_CODGPR ';
  Result := Result + 'WHERE                  ';
  Result := Result + '  ELE_SEQGER = :SEQGER ';
end;

function TComVen.fRetSQLElementoGrupoProduto: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE    ';
  Result := Result + '  ELE_CODGPD,          ';
  Result := Result + '  PRD_DESGRU           ';
  Result := Result + 'FROM                   ';
  Result := Result + '  ELEGPD               ';
  Result := Result + '  LEFT JOIN GRPPRD ON PRD_CODGRU = ELE_CODGPD ';
  Result := Result + 'WHERE                  ';
  Result := Result + '  ELE_SEQGER = :SEQGER ';
end;

function TComVen.fRetSQLElementoLinha: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE    ';
  Result := Result + '  ELE_CODGRU,          ';
  Result := Result + '  GRU_DESGRU           ';
  Result := Result + 'FROM                   ';
  Result := Result + '  ELEGRU               ';
  Result := Result + '  LEFT JOIN CADGRU ON GRU_CODGRU = ELE_CODGRU ';
  Result := Result + 'WHERE                  ';
  Result := Result + '  ELE_SEQGER = :SEQGER ';
end;

function TComVen.fRetSQLElementoMarca: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE    ';
  Result := Result + '  ELE_CODMAR,          ';
  Result := Result + '  MAR_DESMAR           ';
  Result := Result + 'FROM                   ';
  Result := Result + '  ELEMAR               ';
  Result := Result + '  LEFT JOIN CADMAR ON MAR_CODMAR = ELE_CODMAR ';
  Result := Result + 'WHERE                  ';
  Result := Result + '  ELE_SEQGER = :SEQGER ';
end;

function TComVen.fRetSQLFiltroLinhaGrupo: String;
Var
  intCnt      : Integer;
  strSQLLinGru: String;
begin
  strSQLLinGru := '';

  If Not fEmptyStr(getLinGru) Then
  Begin
    If Length(arrSelLin) > 1 Then
    Begin
      For intCnt := Low(arrSelLin) To High(arrSelLin) Do
      Begin
        If Not fEmptyStr(arrSelLin[intCnt].strCodigo) Then
        Begin

          If Not fEmptyStr(strSQLLinGru) Then
          Begin
            strSQLLinGru := strSQLLinGru + ' OR ';
            strLinGru := strLinGru + '_';
          End;

          strLinGru := strLinGru + arrSelLin[intCnt].strCodigo;

          If RightStr(arrSelLin[intCnt].strCodigo,3) = '000' Then
            strSQLLinGru := strSQLLinGru + '(LEFT(ITE_CODGRU,3) = ' + QuotedStr(LeftStr(arrSelLin[intCnt].strCodigo,3)) + ')'
          Else
            strSQLLinGru := strSQLLinGru + '(ITE_CODGRU = ' + QuotedStr(arrSelLin[intCnt].strCodigo) + ')';
        End;
      End;

      If Not fEmptyStr(strSQLLinGru) Then
      Begin
        Result := Result + ' AND (' + strSQLLinGru + ') ';
      End;
    End
    Else
    Begin
      If RightStr(getLinGru, 3) = '000' Then
        Result := Result + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        Result := Result + '  AND ITE_CODGRU = :CODGRU ';
    End;
  End;

end;

function TComVen.fRetSQLInsertEmpresa: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO           ';
  Result := Result + '  COMEMP(             ';
  Result := Result + '          AUTOINCREM, ';
  Result := Result + '          COM_SEQGER, ';
  Result := Result + '          COM_CODEMP  ';
  Result := Result + '         )            ';
  Result := Result + '  VALUES(             ';
  Result := Result + '          :AUTINC,    ';
  Result := Result + '          :SEQGER,    ';
  Result := Result + '          :CODEMP     ';
  Result := Result + '         )            ';
end;

function TComVen.fRetSQLInsertProdutoAtivacao: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO           ';
  Result := Result + '  PROATI(             ';
  Result := Result + '          AUTOINCREM, ';
  Result := Result + '          ATI_SEQGER, ';
  Result := Result + '          ATI_CODITE, ';
  Result := Result + '          ATI_QTDITE  ';
  Result := Result + '         )            ';
  Result := Result + '  VALUES(             ';
  Result := Result + '          :AUTOIN,    ';
  Result := Result + '          :SEQGER,    ';
  Result := Result + '          :CODITE,    ';
  Result := Result + '          :QTDITE     ';
  Result := Result + '         )            ';
end;

function TComVen.fRetSQLInsertProdutoCombo: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO           ';
  Result := Result + '  PROCOM(             ';
  Result := Result + '         AUTOINCREM,  ';
  Result := Result + '         COM_SEQGER,  ';
  Result := Result + '         COM_CODITE,  ';
  Result := Result + '         COM_QTDITE,  ';
  Result := Result + '         COM_BRINDE,  ';
  Result := Result + '         COM_TABPRE,  ';
  Result := Result + '         COM_OPERAD,  ';
  Result := Result + '         COM_TIPDES,  ';
  Result := Result + '         COM_VALDES   ';
  Result := Result + '         )            ';
  Result := Result + '  VALUES(             ';
  Result := Result + '         :AUTOIN,     ';
  Result := Result + '         :SEQGER,     ';
  Result := Result + '         :CODITE,     ';
  Result := Result + '         :QTDITE,     ';
  Result := Result + '         :BRINDE,     ';
  Result := Result + '         :TABPRE,     ';
  Result := Result + '         :OPERAD,     ';
  Result := Result + '         :TIPDES,     ';
  Result := Result + '         :VALDES      ';
  Result := Result + '         )            ';
end;

function TComVen.fRetSQLInsertProdutoSimilar: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO           ';
  Result := Result + '  PROSIM(             ';
  Result := Result + '         AUTOINCREM,  ';
  Result := Result + '         SIM_SEQGER,  ';
  Result := Result + '         SIM_CODITE   ';
  Result := Result + '         )            ';
  Result := Result + '  VALUES(             ';
  Result := Result + '         :AUTOIN,     ';
  Result := Result + '         :SEQGER,     ';
  Result := Result + '         :CODITE      ';
  Result := Result + '         )            ';
end;

function TComVen.fSelecionouEmpresa: Boolean;
Var
  intContador: Integer;
begin
  Result := False;

  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If (clbEmpresa.Checked[intContador]) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TComVen.fTodosProdutosAtivacaoTemProdutoCombo: Boolean;
begin
  Result := fChamaTelaGravando(fTodosProdutosAtivacaoTemProdutoComboInterna);
end;

function TComVen.fTodosProdutosAtivacaoTemProdutoComboInterna(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  Try

    With cdsProAti Do
    Begin
      setFilCom(False);
      First;
      setFilCom(True);

      While Not Eof Do
      Begin
        pInformacao('Aguarde...Validando Produtos de Ativação: ' + #13#10 + FieldByName('CODITEA').AsString + '-' + Copy(FieldByName('DESITEA').AsString, 1, 15), pgbProgresso);

        If (cdsProCom.IsEmpty) Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fTodosProdutosAtivacaoTemProdutoCombo]');
  End;

  setFilCom(False);
  setFilCom(True);
end;

function TComVen.fValidaProdutoOutroComboVigenteInterna(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strMsgGer: String;
begin

  Result := False;

  Try

    pInfoStatusGravacao(pgbProgresso, 'Aguarde... Validando Produto de Ativação...');
    pPreparaEmpresasSelecionadas;

    With cdsProAti Do
    Begin
      First;
      strMsgGer := '';
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Validando Produto de Ativação...' + #13#10 + FieldByName('CODITEA').AsString + '-' + Copy(FieldByName('DESITEA').AsString, 1, 15));

        If (fProdutoJaEstaEmOutroCombo(FieldByName('CODITEA').AsString)) Then
        Begin
          strMsgGer := strMsgGer + getMsgCom;
        End;

        pStepStatusGravacao(pgbProgresso);
        Next;
      End;

      First;

      If (fEmptyStr(strMsgGer)) Then
        Result := True
      Else
      Begin
        setMsgCom(strMsgGer);
        pMostraProdutosJaExistentesOutroCombo;
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.fValidaProdutoOutroComboVigente]')
  End;

end;

function TComVen.getAddPro: Boolean;
begin
  Result := blnAddPro;
end;

function TComVen.getAddPAt: Boolean;
begin
  Result := blnAddPAt;
end;

function TComVen.getArrFor: TConsultasArray;
begin
  Result := arrSelFor;
end;

function TComVen.getArrIte: TConsultasArray;
begin
  Result := arrSelIte;
end;

function TComVen.getArrMar: TConsultasArray;
begin
  Result := arrSelMar;
end;

function TComVen.getArrUni: TConsultasArray;
begin
  Result := arrSelUni;
end;

function TComVen.getAutInc: String;
begin
  Result := strAutInc;
end;

function TComVen.getAutIncProAti: String;
begin
  If (cdsProAti.Active) Then
    Result := cdsProAti.FieldByName('AUTINCA').AsString;
end;

function TComVen.getAutIncProCom: String;
begin
  If (cdsProCom.Active) Then
    Result := cdsProCom.FieldByName('AUTINCC').AsString;
end;

function TComVen.getBrinde: String;
begin
  Result := strBrinde;
end;

function TComVen.getCdsEle: TUniClientDataSet;
begin
  If (tipTipEle = telLinhaGrupo) Then
    Result := cdsEleGru
  Else If (tipTipEle = telMarca) Then
    Result := cdsEleMar
  Else If (tipTipEle = telFornecedor) Then
    Result := cdsEleFor
  Else If (tipTipEle = telGrupoProd) Then
    Result := cdsEleGPd
  Else
    Result := cdsEleGPr;
end;

function TComVen.getCdsElemen: TUniClientDataSet;
begin
  Result := cdsElemen;
end;

function TComVen.getCdsProAti: TUniClientDataSet;
begin
  Result := cdsProAti;
end;

function TComVen.getCdsProCom: TUniClientDataSet;
begin
  Result := cdsProCom;
end;

function TComVen.getCdsProSim: TUniClientDataSet;
begin
  Result := cdsProSim;
end;

procedure TComVen.pCarregaClientElementos;
Var
  qryEleTmp: TUniQuery;
begin

  Try

    qryEleTmp := fCriaQuery(Nil);

    With qryEleTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLElementoLinha);
      ParamByName('SEQGER').AsString := getAutInc;
      Open;
      pInsereElementosLinhaGrupo(qryEleTmp);

      Close;
      SQL.Clear;
      SQL.Add(fRetSQLElementoMarca);
      ParamByName('SEQGER').AsString := getAutInc;
      Open;
      pInsereElementosMarca(qryEleTmp);

      Close;
      SQL.Clear;
      SQL.Add(fRetSQLElementoFornecedor);
      ParamByName('SEQGER').AsString := getAutInc;
      Open;
      pInsereElementosFornecedor(qryEleTmp);

      Close;
      SQL.Clear;
      SQL.Add(fRetSQLElementoGrupoPreco);
      ParamByName('SEQGER').AsString := getAutInc;
      Open;
      pInsereElementosGrupoPrecos(qryEleTmp);

      Close;
      SQL.Clear;
      SQL.Add(fRetSQLElementoGrupoProduto);
      ParamByName('SEQGER').AsString := getAutInc;
      Open;
      pInsereElementosGrupoProdutos(qryEleTmp);
    End;

    pMarcaElementoExistente;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaClientElementos]');
  End;

  FreeAndNil(qryEleTmp);

end;

function TComVen.getCodFor: String;
begin
  Result := strCodFor;
end;

function TComVen.getCodIte: String;
begin
  Result := strCodIte;
end;

function TComVen.getCodMar: String;
begin
  Result := strCodMar;
end;

function TComVen.getCodUni: String;
begin
  Result := strCodUni;
end;

function TComVen.getDesFin: String;
begin
  Result := strDesFin;
end;

function TComVen.getDesIni: String;
begin
  Result := strDesIni;
end;

function TComVen.getDtaFin: TDate;
begin
  Result := dtaDtaFin;
end;

function TComVen.getDtaIni: TDate;
begin
  Result := dtaDtaIni;
end;

function TComVen.getEmpSel: String;
begin
  Result := strEmpSel;
end;

function TComVen.getFilCom: Boolean;
begin
  Result := blnFilCom;
end;

function TComVen.getFilSim: Boolean;
begin
  Result := blnFilSim;
end;

function TComVen.getIncAti: Integer;
begin
  Result := intIncAti;
end;

function TComVen.getIncCom: Integer;
begin
  Result := intIncCom;
end;

function TComVen.getLinGru: String;
begin
  Result := strLinGru;
end;

function TComVen.getMsgCom: String;
begin
  Result := strMsgCom;
end;

function TComVen.getOperad: String;
begin
  Result := strOperad;
end;

function TComVen.getQtdIte: Double;
begin
  Result := fltQtdIte;
end;

function TComVen.getQueryComVen: TUniQuery;
begin
  Result := qryComVen;
end;

function TComVen.getRefere: String;
begin
  Result := strRefere;
end;

function TComVen.getTabIte: String;
begin
  Result := strTabIte;
end;

function TComVen.getTabPre: String;
begin
  Result := strTabPre;
end;

function TComVen.getTipDes: String;
begin
  Result := strTipDes;
end;

function TComVen.getTipEle: TTipEle;
begin
  Result := tipTipEle;
end;

function TComVen.getTipPro: TTipProCombo;
begin
  Result := tipTipPro;
end;

function TComVen.getTodosAutIncProAti: String;
begin
  Result := '';

  With cdsProAti Do
  Begin

    First;

    setFilCom(False);

    While Not Eof Do
    Begin
      Result := Result + FieldByName('AUTINCA').AsString + ',';
      Next;
    End;

    Result := Copy(Result, 1, Length(Result) - 1);

    First;

    setFilCom(True);
    pFiltraProdutosCombo;
  End;
end;

function TComVen.getTodosAutIncProCom: String;
begin
  Result := '';

  With cdsProCom Do
  Begin
    First;

    cdsProCom.Filter   := '';
    cdsProCom.Filtered := False;
    setFilSim(False);

    While Not Eof Do
    Begin
      Result := Result + FieldByName('AUTINCC').AsString + ',';
      Next;
    End;

    Result := Copy(Result, 1, Length(Result) - 1);

    First;

    setFilSim(True);
    pFiltraProdutosCombo;
    pFiltraProdutosSimilares;
  End;
end;

function TComVen.getValDes: Double;
begin
  Result := fltValDes;
end;

function TComVen.fAbreFiltroProduto: Boolean;
begin

  Result := False;

  Try

    pCriarFormularios(TfrmFiltrosProdutos, frmFiltrosProdutos);
    frmFiltrosProdutos.tipTipPro := getTipPro;

    If (getTipPro = pcoAtivacao) Then
      frmFiltrosProdutos.blnTemPro := (Not cdsProAti.IsEmpty)
    Else If (getTipPro = pcoCombo) Then
      frmFiltrosProdutos.blnTemPro := (Not cdsProCom.IsEmpty)
    Else If (getTipPro = pcoSimilar) Then
      frmFiltrosProdutos.blnTemPro := (Not cdsProSim.IsEmpty);

    frmFiltrosProdutos.ShowModal;

    If (frmFiltrosProdutos.ModalResult = mrOk) Then
    Begin
      setCodIte(frmFiltrosProdutos.edtCodIte.Text);
      setArrIte(frmFiltrosProdutos.arrSelIte);
      setLinGru(frmFiltrosProdutos.mskLinGru.Text);
      setArrGru(frmFiltrosProdutos.arrSelGru);
      setCodMar(frmFiltrosProdutos.edtCodMar.Text);
      setArrMar(frmFiltrosProdutos.arrSelMar);
      setCodFor(frmFiltrosProdutos.edtCodFor.Text);
      setArrFor(frmFiltrosProdutos.arrSelFor);
      setDesIni(frmFiltrosProdutos.edtDesIni.Text);
      setDesFin(frmFiltrosProdutos.edtDesFin.Text);
      setRefere(frmFiltrosProdutos.edtRefere.Text);
      setCodUni(frmFiltrosProdutos.edtCodUni.Text);
      setArrUni(frmFiltrosProdutos.arrSelUni);
      setQtdIte(fStrToFloat(frmFiltrosProdutos.edtQtdIte.Text));
      setAddPro(frmFiltrosProdutos.chkAddPro.Checked);
      setAddPAt(frmFiltrosProdutos.chkAddPAt.Checked);
      setBrinde('');
      setTabIte('');
      setOperad('');
      setTipDes('');
      setValDes(0);

      If (getTipPro = pcoCombo) Then
      Begin
        If (frmFiltrosProdutos.cmbBrinde.ItemIndex = 0) Then
          setBrinde('S')
        Else
        Begin
          setBrinde('N');

          setTabIte(frmFiltrosProdutos.cmbTabPre.Text);

          If (frmFiltrosProdutos.cmbOperad.ItemIndex = 0) Then
            setOperad('+')
          Else
            setOperad('-');

          If (frmFiltrosProdutos.cmbTipDes.ItemIndex = 0) Then
            setTipDes('%')
          Else
            setTipDes('$');

          setValDes(fstrToFloat(frmFiltrosProdutos.edtValDes.Text));
        End;
      End;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pAbreFiltroProduto]')
  End;

  pFreeAndNil(frmFiltrosProdutos);

  If (Result) Then
  Begin
    If (getTipPro = pcoAtivacao) Then
      pCarregaProdutosAtivacaoFiltro
    Else If (getTipPro = pcoCombo) Then
      pCarregaProdutosComboFiltro
    Else If (getTipPro = pcoSimilar) Then
      pCarregaProdutosSimilaresFiltro;
  End;

end;

procedure TComVen.pAbreTelaAjusteElemento;
  Var
    frmCadElemCombo : TfrmCadElemCombo;
begin
  Try
    pFazBackupDadosElemento;
    pCriarFormularios(TfrmCadElemCombo, frmCadElemCombo);
    frmCadElemCombo.tipTipEle := getTipEle;
    frmCadElemCombo.cdsElemen := getCdsEle;
    frmCadElemCombo.ShowModal;

    If (frmCadElemCombo.modalResult <> mrOk) Then
      pRestauraDadosElemento;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TComVen.pAbreTelaAjusteElemento]');
  End;

  pFreeAndNil(frmCadElemCombo);

end;

procedure TComVen.pAfterOpen(DataSet: TDataSet);
begin
  TDateField(DataSet.FieldByName('COM_DTAINI')).EditMask := '99/99/9999';
  TDateField(DataSet.FieldByName('COM_DTAFIN')).EditMask := '99/99/9999';
end;

procedure TComVen.pAfterScrollProAti(DataSet: TDataSet);
begin
  pFiltraProdutosCombo;
end;

procedure TComVen.pAfterScrollProCom(DataSet: TDataSet);
begin
  pFiltraProdutosSimilares;
end;

procedure TComVen.pAjustaElementos;
begin
  pDefineTipoElemento;
  pAbreTelaAjusteElemento;
  pMarcaElementoExistente;
end;

procedure TComVen.pAlteraDadosProduto;
var
  frmAlteraProdCombo: TfrmAlteraProdCombo;
begin

  If Not (getTipPro In [pcoAtivacao, pcoCombo]) Then
    Exit;

  Try

    pCriarFormularios(TfrmAlteraProdCombo, frmAlteraProdCombo);

    If (getTipPro = pcoAtivacao) Then
    Begin
      frmAlteraProdCombo.tipTipPro      := pcoAtivacao;
      frmAlteraProdCombo.edtCodIte.Text := cdsProAti.FieldByName('CODITEA').AsString;
      frmAlteraProdCombo.edtDesIte.Text := cdsProAti.FieldByName('DESITEA').AsString;
      frmAlteraProdCombo.edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd), cdsProAti.FieldByName('QTDITEA').AsFloat);
    End
    Else If (getTipPro = pcoCombo) Then
    Begin
      frmAlteraProdCombo.tipTipPro      := pcoCombo;
      frmAlteraProdCombo.edtCodIte.Text := cdsProCom.FieldByName('CODITEC').AsString;
      frmAlteraProdCombo.edtDesIte.Text := cdsProCom.FieldByName('DESITEC').AsString;
      frmAlteraProdCombo.edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd), cdsProCom.FieldByName('QTDITEC').AsFloat);

      If (cdsProCom.FieldByName('BRINDEC').AsString = 'S') Then
      Begin
        frmAlteraProdCombo.cmbBrinde.ItemIndex := 0;
        frmAlteraProdCombo.cmbBrinde.OnChange(frmAlteraProdCombo.cmbBrinde);
      End
      Else
      Begin
        frmAlteraProdCombo.cmbBrinde.ItemIndex := 1;
        frmAlteraProdCombo.cmbBrinde.OnChange(frmAlteraProdCombo.cmbBrinde);

        If (cdsProCom.FieldByName('TABPREC').AsString = 'F' ) Then
          frmAlteraProdCombo.cmbTabPre.ItemIndex := frmAlteraProdCombo.cmbTabPre.Items.IndexOf('FAT')
        Else
          frmAlteraProdCombo.cmbTabPre.ItemIndex := frmAlteraProdCombo.cmbTabPre.Items.IndexOf(cdsProCom.FieldByName('TABPREC').AsString);

        If (cdsProCom.FieldByName('OPERADC').AsString = '+') Then
          frmAlteraProdCombo.cmbOperad.ItemIndex := 0
        Else
          frmAlteraProdCombo.cmbOperad.ItemIndex := 1;

        If (cdsProCom.FieldByName('TIPDESC').AsString = '%') Then
          frmAlteraProdCombo.cmbTipDes.ItemIndex := 0
        Else
          frmAlteraProdCombo.cmbTipDes.ItemIndex := 1;

        frmAlteraProdCombo.edtValDes.Text := FormatFloat(fMskDigitos(2), cdsProCom.FieldByName('VALDESC').AsFloat);
      End;
    End;

    frmAlteraProdCombo.ShowModal;

    If (frmAlteraProdCombo.ModalResult = mrOk) Then
    Begin
      If (getTipPro = pcoAtivacao) Then
      Begin
        cdsProAti.Edit;
        cdsProAti.FieldByName('QTDITEA').AsFloat := fStrToFloat(frmAlteraProdCombo.edtQtdIte.Text);
        cdsProAti.Post;
      End
      Else If (getTipPro = pcoCombo) Then
      Begin
        cdsProCom.Edit;
        cdsProCom.FieldByName('QTDITEC').AsFloat := fStrToFloat(frmAlteraProdCombo.edtQtdIte.Text);

        If (frmAlteraProdCombo.cmbBrinde.ItemIndex = 0) Then
          cdsProCom.FieldByName('BRINDEC').AsString := 'S'
        Else
          cdsProCom.FieldByName('BRINDEC').AsString := 'N';

        cdsProCom.FieldByName('TABPREC').AsString := frmAlteraProdCombo.cmbTabPre.Text;

        cdsProCom.FieldByName('OPERADC').AsString := '';

        If (frmAlteraProdCombo.cmbOperad.ItemIndex = 0) Then
          cdsProCom.FieldByName('OPERADC').AsString := '+'
        Else If (frmAlteraProdCombo.cmbOperad.ItemIndex = 1) Then
          cdsProCom.FieldByName('OPERADC').AsString := '-';

        cdsProCom.FieldByName('TIPDESC').AsString := '';

        If (frmAlteraProdCombo.cmbTipDes.ItemIndex = 0) Then
          cdsProCom.FieldByName('TIPDESC').AsString := '%'
        Else If (frmAlteraProdCombo.cmbTipDes.ItemIndex = 1) Then
          cdsProCom.FieldByName('TIPDESC').AsString := '$';

        cdsProCom.FieldByName('VALDESC').AsFloat := fstrToFloat(frmAlteraProdCombo.edtValDes.Text);
        cdsProCom.Post;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pAlteraDadosProduto]')
  End;

  pFreeAndNil(frmAlteraProdCombo);

end;

procedure TComVen.pAlterarDadosProdutoAtivacao;
begin
  If (fExisteProdutosAtivacao) Then
  Begin
    setTipPro(pcoAtivacao);
    pAlteraDadosProduto;
  End;
end;

procedure TComVen.pAlterarDadosProdutoCombo;
begin
  If (fExisteProdutosCombo) Then
  Begin
    setTipPro(pcoCombo);
    pAlteraDadosProduto;
  End;
end;

procedure TComVen.pApagaRegistro;
begin
  setFilCom(False);
  setFilSim(False);

  If (tipTipPro = pcoAtivacao)    And
     (Not cdsProAti.IsEmpty)      Then
  Begin
    If (fExisteProdutosCombo) Then
    Begin
      If (fMensagem('ATENÇÃO!', 'Existem Produtos do Combo vinculados a este Produto de Ativação!' + #13#10 +
                                'Deseja realmente excluir este Produto e seus vínculos com o Combo e Similares?', ['&S i m', '&N ã o'], 2) = 1) Then
        pDeletaProdutoAtivacao;
    End
    Else
      pDeletaProdutoAtivacao
  End
  Else If (tipTipPro = pcoCombo)  And
          (Not cdsProCom.IsEmpty) Then
  Begin
    If (fExisteProdutosSimilares) Then
    Begin
      If (fMensagem('ATENÇÃO!', 'Existem Produtos Similares vinculados a este Produto do Combo!' + #13#10 +
                                'Deseja realmente excluir este Produto e seus vínculos com Similares?', ['&S i m', '&N ã o'], 2) = 1) Then
        pDeletaProdutoCombo;
    End
    Else
      pDeletaProdutoCombo;
  End
  Else If (tipTipPro = pcoSimilar)  And
          (Not cdsProSim.IsEmpty) Then
    cdsProSim.Delete;

  setFilCom(True);
  setFilSim(True);

  If (tipTipPro = pcoAtivacao) Then
  Begin
    pFiltraProdutosCombo;
    pFiltraProdutosSimilares;
  End
  Else If (tipTipPro = pcoCombo) Then
    pFiltraProdutosSimilares;

end;

procedure TComVen.pCarregaDadosAlteracao;
begin
  fChamaTelaGravando(fCarregaDadosAlteracao);
end;

procedure TComVen.pCarregaElementos;
begin
  setLength(arrDadEle, 5);
  arrDadEle[0].strCodEle := 'ELEGRU';
  arrDadEle[0].strDesEle := 'LINHA/GRUPO';

  arrDadEle[1].strCodEle := 'ELEMAR';
  arrDadEle[1].strDesEle := 'MARCA';

  arrDadEle[2].strCodEle := 'ELEFOR';
  arrDadEle[2].strDesEle := 'FORNECEDOR';

  arrDadEle[3].strCodEle := 'ELEGPD';
  arrDadEle[3].strDesEle := 'GRUPO DE PRODUTOS';

  arrDadEle[4].strCodEle := 'ELEGPR';
  arrDadEle[4].strDesEle := 'GRUPO DE PREÇOS';
end;

procedure TComVen.pCarregaEmpresas;
Var
  intContador : Integer;
Begin

  Try

    With qryGeneri, SQL Do
    Begin
      clbEmpresa.Items.Clear;
      Clear;
      Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP');
      Open;
      First;

      While Not Eof Do
      Begin
        clbEmpresa.Items.Add(FieldByName('EMPNOM').AsString);
        Next;
      End;
      Close;
    End;

    {********************************}
    {* SELECIONA TODAS AS EMPRESAS  *}
    {*****************************PZ*}
    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      clbEmpresa.Checked[intContador] := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaEmpresas]');
  End;

End;

procedure TComVen.pCarregaProdutosAtivacao;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT                    ';
    strSQL := strSQL + '  PROATI.AUTOINCREM AS AUTINCA,  ';
    strSQL := strSQL + '  ATI_CODITE        AS CODITEA,  ';
    strSQL := strSQL + '  ATI_QTDITE        AS QTDITEA,  ';
    strSQL := strSQL + '  ITE_DESITE        AS DESITEA,  ';
    strSQL := strSQL + '  ITE_REFERE        AS REFEREA,  ';
    strSQL := strSQL + '  UNI_SIGUNI        AS SIGUNIA   ';
    strSQL := strSQL + 'FROM                      ';
    strSQL := strSQL + '  PROATI                  ';
    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = ATI_CODITE ';
    strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
    strSQL := strSQL + 'WHERE                     ';
    strSQL := strSQL + '  ATI_SEQGER = :SEQGER    ';

    If (cdsProAti.Active) Then
    Begin
      cdsProAti.EmptyDataSet;
      cdsProAti.Close;
      cdsProAti.SetProvider(dspProAti);
      cdsProAti.AfterScroll := Nil;
    End;

    With qryProAti Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := getAutInc;
      Open;
      pSetaClient(qryProAti);

      cdsProAti.AfterScroll := pAfterScrollProAti;

      cdsProAti.Open;
      cdsProAti.First;
      pSetaClient(cdsProAti);

      cdsProAti.IndexFieldNames := 'DESITEA';
      TFloatField(cdsProAti.FieldByName('QTDITEA')).DisplayFormat := fMskDigitos(intDecQtd);

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosAtivacao]');
  End;

end;

procedure TComVen.pCarregaProdutosAtivacaoFiltro;
begin
  fChamaTelaGravando(fCarregaProdutosAtivacaoFiltro);
end;

procedure TComVen.pCarregaProdutosCombo;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT                    ';
    strSQL := strSQL + '  PROCOM.AUTOINCREM AS AUTINCC,  ';
    strSQL := strSQL + '  COM_SEQGER AS SEQGERC,  ';
    strSQL := strSQL + '  COM_CODITE AS CODITEC,  ';
    strSQL := strSQL + '  COM_QTDITE AS QTDITEC,  ';
    strSQL := strSQL + '  ITE_DESITE AS DESITEC,  ';
    strSQL := strSQL + '  ITE_REFERE AS REFEREC,  ';
    strSQL := strSQL + '  COM_BRINDE AS BRINDEC,  ';
    strSQL := strSQL + '  COM_TABPRE AS TABPREC,  ';
    strSQL := strSQL + '  COM_OPERAD AS OPERADC,  ';
    strSQL := strSQL + '  COM_TIPDES AS TIPDESC,  ';
    strSQL := strSQL + '  COM_VALDES AS VALDESC,  ';
    strSQL := strSQL + '  UNI_SIGUNI AS SIGUNIC   ';
    strSQL := strSQL + 'FROM                      ';
    strSQL := strSQL + '  PROCOM                  ';
    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = COM_CODITE ';
    strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
    strSQL := strSQL + 'WHERE                     ';
    strSQL := strSQL + '  LOCATE(COM_SEQGER, :SEQGER) > 0 ';

    If (cdsProCom.Active) Then
    Begin
      cdsProCom.EmptyDataSet;
      cdsProCom.Close;
      cdsProCom.SetProvider(dspProCom);
      cdsProCom.AfterScroll := Nil;
    End;

    With qryProCom Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := getTodosAutIncProAti;
      Open;
      pSetaClient(qryProCom);

      cdsProCom.AfterScroll := pAfterScrollProCom;

      cdsProCom.Open;
      cdsProCom.First;
      pSetaClient(cdsProCom);

      cdsProCom.IndexFieldNames := 'DESITEC';
      TFloatField(cdsProCom.FieldByName('QTDITEC')).DisplayFormat := fMskDigitos(intDecQtd);
      TFloatField(cdsProCom.FieldByName('VALDESC')).DisplayFormat := '#,##0.00';

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosCombo]');
  End;

end;

procedure TComVen.pCarregaProdutosComboFiltro;
begin
  fChamaTelaGravando(fCarregaProdutosComboFiltro);
end;

procedure TComVen.pCarregaProdutosSimilares;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT                    ';
    strSQL := strSQL + '  SIM_SEQGER AS SEQGERS,  ';
    strSQL := strSQL + '  SIM_CODITE AS CODITES,  ';
    strSQL := strSQL + '  ITE_DESITE AS DESITES,  ';
    strSQL := strSQL + '  ITE_REFERE AS REFERES,  ';
    strSQL := strSQL + '  UNI_SIGUNI AS SIGUNIS   ';
    strSQL := strSQL + 'FROM                      ';
    strSQL := strSQL + '  PROSIM                  ';
    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = SIM_CODITE ';
    strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
    strSQL := strSQL + 'WHERE                     ';
    strSQL := strSQL + '  LOCATE(SIM_SEQGER, :SEQGER) > 0 ';

    If (cdsProSim.Active) Then
    Begin
      cdsProSim.EmptyDataSet;
      cdsProSim.Close;
      cdsProSim.SetProvider(dspProSim);
    End;

    With qryProSim Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := getTodosAutIncProCom;
      Open;
      pSetaClient(qryProSim);

      cdsProSim.Open;
      cdsProSim.First;
      pSetaClient(cdsProSim);

      cdsProSim.IndexFieldNames := 'DESITES';
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosSimilares]');
  End;

end;

procedure TComVen.pCarregaProdutosSimilaresFiltro;
begin
  fChamaTelaGravando(fCarregaProdutosSimilaresFiltro);
end;

procedure TComVen.pMarcaElementoExistente;
Var
  intRecNo: Integer;
begin

  With cdsElemen Do
  Begin
    intRecNo := RecNo;
    First;

    While Not Eof Do
    Begin
      If ((FieldByName('CODELE').AsString = 'ELEGRU') And  (fExisteElementoLinhaGrupo))   Or
         ((FieldByName('CODELE').AsString = 'ELEMAR') And  (fExisteElementoMarca))        Or
         ((FieldByName('CODELE').AsString = 'ELEFOR') And  (fExisteElementoFornecedor))   Or
         ((FieldByName('CODELE').AsString = 'ELEGPD') And  (fExisteElementoGrupoProduto)) Or
         ((FieldByName('CODELE').AsString = 'ELEGPR') And  (fExisteElementoGrupoPreco))   Then
      Begin
        Edit;
        FieldByName('TEMREG').AsString := 'S';
        Post;
      End
      Else
      Begin
        Edit;
        FieldByName('TEMREG').AsString := 'N';
        Post;
      End;

      Next;
    End;

    RecNo := intRecNo;
  End;
end;

procedure TComVen.pMarcaSelecaoEmpresas;
Var
  intContador: Integer;
  strSQL     : String;
  strEmpSel  : String;
Begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  GROUP_CONCAT(COM_CODEMP) AS COM_CODEMP  ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  COMEMP               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  COM_SEQGER = :SEQGER ';

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := getAutInc;
      Open;
      strEmpSel := FieldByName('COM_CODEMP').AsString;
    End;

    {********************************}
    {* SELECIONA TODAS AS EMPRESAS  *}
    {*****************************PZ*}
    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      If (Pos(Leftstr(clbEmpresa.Items[intContador], 3), strEmpSel) > 0) Then
        clbEmpresa.Checked[intContador] := True
      Else
        clbEmpresa.Checked[intContador] := False;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaEmpresasAlteracao]');
  End;

end;

procedure TComVen.pMarcaSelecaoTabelaPreco;
Var
  intContador: Integer;
begin

  Try

    For intContador := 0 To clbTabPre.Items.Count - 1 Do
    Begin
      If (Length(strTabPre) >= (intContador + 1)) And (strTabPre[intContador + 1] = 'S') And (VS_strTabVen[intContador + 1] = 'S') Then
        clbTabPre.Checked[intContador] := True
      Else
        clbTabPre.Checked[intContador] := False;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pMarcaSelecaoTabelaPreco]');
  End;

end;

procedure TComVen.pMarcaTodasEmpresas;
Var
  intContador: Integer;
begin
  For intContador := 0 To clbEmpresa.Items.Count - 1 Do
  Begin
    clbEmpresa.Checked[intContador] := True;
  End;
end;

procedure TComVen.pMarcaTodasTabelasPrecos;
Var
  intContador: Integer;
begin
  For intContador := 0 To clbTabPre.Items.Count -1 Do
    clbTabPre.Checked[intContador] := VS_strTabVen[Succ(intContador)] = 'S';
end;

procedure TComVen.pMostraProdutosJaExistentesOutroCombo;
begin

  If (fEmptyStr(getMsgCom)) Then
    Exit;

  Try
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.lblMensagem.Caption    := 'Os itens abaixo já estão incluidos em outros combos vigentes:';
    frmObservacao.lblMensagem.font.Style := [fsBold];
    frmObservacao.memObs.Texto           := getMsgCom;
    frmObservacao.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TComVen.pMostraProdutosJaExistentesOutroCombo]');
    End;
  End;

  pFreeAndNil(frmObservacao);

end;

procedure TComVen.pPreparaEmpresasSelecionadas;
Var
  intContador: Integer;
  strEmpTmp  : String;
begin

  strEmpTmp := '';

  For intContador := 0 To clbEmpresa.Items.Count - 1 Do
  Begin
    If (clbEmpresa.Checked[intContador]) Then
    Begin
      If (intContador = 0) Then
        strEmpTmp := strEmpTmp + LeftStr(clbEmpresa.Items[intContador], 3)
      Else
        strEmpTmp := strEmpTmp + ',' + LeftStr(clbEmpresa.Items[intContador], 3);
    End;
  End;

  setEmpSel(strEmpTmp);

end;

procedure TComVen.pRestauraDadosElemento;
begin
  If (tipTipEle = telLinhaGrupo) Then
    cdsEleGru.Data := oleBkpEle
  Else If (tipTipEle = telMarca) Then
    cdsEleMar.Data := oleBkpEle
  Else If (tipTipEle = telFornecedor) Then
    cdsEleFor.Data := oleBkpEle
  Else If (tipTipEle = telGrupoProd) Then
    cdsEleGPd.Data := oleBkpEle
  Else
    cdsEleGPr.Data := oleBkpEle;
end;

procedure TComVen.pSetaParametrosProdutosFiltro;
Var
  strProdut: String;
  strFornec: String;
  strMarcas: String;
  strUnidad: String;
begin
  With qryGeneri Do
  Begin
    pSetaParam(getCodIte, getArrIte, strProdut, 'CODITE', qryGeneri);
    pSetaParam(getCodFor, getArrFor, strFornec, 'CODFOR', qryGeneri);
    pSetaParam(getCodMar, getArrMar, strMarcas, 'CODMAR', qryGeneri);
    pSetaParam(getCodUni, getArrUni, strUnidad, 'CODUNI', qryGeneri);

    If (Params.FindParam('CODGRU') <> Nil) Then
      ParamByName('CODGRU').AsString := getLinGru;

    If (Not fEmptyStr(getDesIni)) and (Not fEmptyStr(getDesFin)) Then
    Begin
      ParamByName('MAIOR').AsString   := getDesIni;
      ParamByName('DESITE').AsString  := getDesIni;
      ParamByName('DESITE1').AsString := getDesFin;
    End
    Else
    Begin
      If (Not fEmptyStr(getDesIni)) Then
        ParamByName('DESITE').AsString := getDesIni + '%';
    End;

    If (Not fEmptyStr(getRefere)) Then
      ParamByName('REFERE').AsString := getRefere;
  End;
end;

procedure TComVen.pCriaClientElementos;
Var
  intContador: Integer;
begin
  With cdsElemen Do
  Begin
    With FieldDefs.AddFieldDef Do Begin Name := 'CODELE'; DataType := ftString; Size := 006; Required := False; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'DESELE'; DataType := ftString; Size := 020; Required := False; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'TEMREG'; DataType := ftString; Size := 001; Required := False; End;
    CreateDataSet;

    For intContador := 0 To Length(arrDadEle) - 1 Do
    Begin
      Insert;
      FieldByName('CODELE').AsString := arrDadEle[intContador].strCodEle;
      FieldByName('DESELE').AsString := arrDadEle[intContador].strDesEle;
      FieldByName('TEMREG').AsString := 'N';
      Post;
    End;

    First;
  End;

  With cdsEleGru Do
  Begin
    With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO'; DataType := ftString; Size := 006; Required := False; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'DESCRI'; DataType := ftString; Size := 070; Required := False; End;
    CreateDataSet;
  End;

  With cdsEleMar Do
  Begin
    With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO'; DataType := ftString; Size := 006; Required := False; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'DESCRI'; DataType := ftString; Size := 030; Required := False; End;
    CreateDataSet;
  End;

  With cdsEleFor Do
  Begin
    With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO'; DataType := ftString; Size := 008; Required := False; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'DESCRI'; DataType := ftString; Size := 060; Required := False; End;
    CreateDataSet;
  End;

  With cdsEleGPr Do
  Begin
    With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO'; DataType := ftString; Size := 006; Required := False; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'DESCRI'; DataType := ftString; Size := 070; Required := False; End;
    CreateDataSet;
  End;

  With cdsEleGPd Do
  Begin
    With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO'; DataType := ftString; Size := 005; Required := False; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'DESCRI'; DataType := ftString; Size := 040; Required := False; End;
    CreateDataSet;
  End;
end;

procedure TComVen.pCriaComponentes;
begin
  qryGeneri := fCriaQuery(Nil);
  qryHeranc := fCriaQuery(Nil);

  qryComVen := fCriaQuery(Nil);
  qryComVen.AfterOpen := pAfterOpen;

  qryProAti := fCriaQuery(Nil);
  dspProati := TUniDataSetProvider.Create(Nil);
  cdsProAti := TUniClientDataSet.Create(Nil);
  dspProAti.DataSet := qryProAti;
  cdsProAti.SetProvider(dspProAti);
  cdsProAti.AfterScroll := pAfterScrollProAti;

  qryProCom := fCriaQuery(Nil);
  dspProCom := TUniDataSetProvider.Create(Nil);
  cdsProCom := TUniClientDataSet.Create(Nil);
  dspProCom.DataSet := qryProCom;
  cdsProCom.SetProvider(dspProCom);
  cdsProCom.AfterScroll := pAfterScrollProCom;

  qryProSim := fCriaQuery(Nil);
  dspProSim := TUniDataSetProvider.Create(Nil);
  cdsProSim := TUniClientDataSet.Create(Nil);
  dspProSim.DataSet := qryProSim;
  cdsProSim.SetProvider(dspProSim);

  cdsElemen := TUniClientDataSet.Create(Nil);
  cdsEleGru := TUniClientDataSet.Create(Nil);
  cdsEleMar := TUniClientDataSet.Create(Nil);
  cdsEleFor := TUniClientDataSet.Create(Nil);
  cdsEleGPr := TUniClientDataSet.Create(Nil);
  cdsEleGPd := TUniClientDataSet.Create(Nil);
  pCriaClientElementos;
end;

procedure TComVen.pDestroiComponentes;
begin
  FreeAndNil(qryGeneri);
  FreeAndNil(qryHeranc);

  FreeAndNil(qryComVen);

  FreeAndNil(qryProAti);
  FreeAndNil(dspProati);
  FreeAndNil(cdsProAti);

  FreeAndNil(qryProCom);
  FreeAndNil(dspProCom);
  FreeAndNil(cdsProCom);

  FreeAndNil(qryProSim);
  FreeAndNil(dspProSim);
  FreeAndNil(cdsProSim);

  FreeAndNil(cdsElemen);
  FreeAndNil(cdsEleGru);
  FreeAndNil(cdsEleMar);
  FreeAndNil(cdsEleFor);
  FreeAndNil(cdsEleGPr);
  FreeAndNil(cdsEleGPd);
end;

procedure TComVen.pFazBackupDadosElemento;
begin
  If (tipTipEle = telLinhaGrupo) Then
    oleBkpEle := cdsEleGru.Data
  Else If (tipTipEle = telMarca) Then
    oleBkpEle := cdsEleMar.Data
  Else If (tipTipEle = telFornecedor) Then
    oleBkpEle := cdsEleFor.Data
  Else If (tipTipEle = telGrupoProd) Then
    oleBkpEle := cdsEleGPd.Data
  Else
    oleBkpEle := cdsEleGPr.Data;
end;

procedure TComVen.pFiltraProdutosCombo;
begin
  If (getFilCom) Then
  Begin
    setFilSim(False);
    //cdsProCom.Filtered := False;
    cdsProCom.Filter   := 'SEQGERC = ' + QuotedStr(getAutIncProAti);

    If (Not cdsProCom.Filtered) Then
      cdsProCom.Filtered := True;

    setFilSim(True);
    pFiltraProdutosSimilares;
  End;
end;

procedure TComVen.pFiltraProdutosSimilares;
begin
  If (getFilSim) And (cdsProSim.Active) Then
  Begin
    //cdsProSim.Filtered := False;
    cdsProSim.Filter   := 'SEQGERS = ' + QuotedStr(getAutIncProCom);

    If (Not cdsProSim.Filtered) Then
      cdsProSim.Filtered := True;

  End;
end;

procedure TComVen.pIncrementaAutIncProAtivacao;
begin
  setIncAti(getIncAti + 1);
end;

procedure TComVen.pIncrementaAutIncProCombo;
begin
  setIncCom(getIncCom + 1);
end;

procedure TComVen.pInsereElementosFornecedor(qryElemen: TUniQuery);
begin
  With qryElemen Do
  Begin
    First;
    cdsEleFor.EmptyDataset;

    While Not Eof DO
    Begin
      cdsEleFor.Insert;
      cdsEleFor.FieldByName('CODIGO').AsString := FieldByName('ELE_CODFOR').AsString;
      cdsEleFor.FieldByName('DESCRI').AsString := FieldByName('FOR_NOMFOR').AsString;
      cdsEleFor.Post;
      Next;
    End;
  End;
end;

procedure TComVen.pInsereElementosGrupoPrecos(qryElemen: TUniQuery);
begin
  With qryElemen Do
  Begin
    First;
    cdsEleGPr.EmptyDataset;

    While Not Eof DO
    Begin
      cdsEleGPr.Insert;
      cdsEleGPr.FieldByName('CODIGO').AsString := FieldByName('ELE_CODGPR').AsString;
      cdsEleGPr.FieldByName('DESCRI').AsString := FieldByName('GPR_DESCRI').AsString;
      cdsEleGPr.Post;
      Next;
    End;
  End;
end;

procedure TComVen.pInsereElementosGrupoProdutos(qryElemen: TUniQuery);
begin
  With qryElemen Do
  Begin
    First;
    cdsEleGPd.EmptyDataset;

    While Not Eof DO
    Begin
      cdsEleGPd.Insert;
      cdsEleGPd.FieldByName('CODIGO').AsString := FieldByName('ELE_CODGPD').AsString;
      cdsEleGPd.FieldByName('DESCRI').AsString := FieldByName('PRD_DESGRU').AsString;
      cdsEleGPd.Post;
      Next;
    End;
  End;
end;

procedure TComVen.pInsereElementosLinhaGrupo(qryElemen: TUniQuery);
begin
  With qryElemen Do
  Begin
    First;
    cdsEleGru.EmptyDataset;

    While Not Eof DO
    Begin
      cdsEleGru.Insert;
      cdsEleGru.FieldByName('CODIGO').AsString := FieldByName('ELE_CODGRU').AsString;
      cdsEleGru.FieldByName('DESCRI').AsString := FieldByName('GRU_DESGRU').AsString;
      cdsEleGru.Post;
      Next;
    End;
  End;
end;

procedure TComVen.pInsereElementosMarca(qryElemen: TUniQuery);
begin
  With qryElemen Do
  Begin
    First;
    cdsEleMar.EmptyDataset;

    While Not Eof DO
    Begin
      cdsEleMar.Insert;
      cdsEleMar.FieldByName('CODIGO').AsString := FieldByName('ELE_CODMAR').AsString;
      cdsEleMar.FieldByName('DESCRI').AsString := FieldByName('MAR_DESMAR').AsString;
      cdsEleMar.Post;
      Next;
    End;
  End;
end;

function TComVen.fValidaProdutoOutroComboVigente: Boolean;
begin
  Result := fChamaTelaGravando(fValidaProdutoOutroComboVigenteInterna);
end;

procedure TComVen.pValorDefault;
begin
  pCarregaEmpresas;
  pCarregaProdutosAtivacao;
  pCarregaProdutosCombo;
  pCarregaProdutosSimilares;
  pDesmarcaTodasTabelasPrecos;
  pCarregaClientElementos;
end;

procedure TComVen.setAddPro(Value: Boolean);
begin
  blnAddPro := Value;
end;

procedure TComVen.setAddPAt(Value: Boolean);
begin
  blnAddPAt := Value;
end;

procedure TComVen.setArrFor(Value: TConsultasArray);
begin
  arrSelFor := Value;
end;

procedure TComVen.setArrIte(Value: TConsultasArray);
begin
  arrSelIte := Value;
end;

procedure TComVen.setArrGru(Value: TConsultasArray);
begin
  arrSelLin := Value;
end;

procedure TComVen.setArrMar(Value: TConsultasArray);
begin
  arrSelMar := Value;
end;

procedure TComVen.setArrUni(Value: TConsultasArray);
begin
  arrSelUni := Value;
end;

procedure TComVen.setAutInc(Value: String);
begin
  strAutInc := Value;
end;

procedure TComVen.setBrinde(Value: String);
begin
  strBrinde := Value;
end;

procedure TComVen.setCodFor(Value: String);
begin
  strCodFor := Value;
end;

procedure TComVen.setCodIte(Value: String);
begin
  strCodIte := Value;
end;

procedure TComVen.setCodMar(Value: String);
begin
  strCodMar := Value;
end;

procedure TComVen.setCodUni(Value: String);
begin
  strCodUni := Value;
end;

procedure TComVen.setDesFin(Value: String);
begin
  strDesFin := Value;
end;

procedure TComVen.setDesIni(Value: String);
begin
  strDesIni := Value;
end;

procedure TComVen.setDtaFin(Value: TDate);
begin
  dtaDtaFin := Value;
end;

procedure TComVen.setDtaIni(Value: TDate);
begin
  dtaDtaIni := Value;
end;

procedure TComVen.setEmpresas(Value: TCheckListBox);
begin
  clbEmpresa := Value;
end;

procedure TComVen.setEmpSel(Value: String);
begin
  strEmpSel := Value;
end;

procedure TComVen.setFilCom(Value: Boolean);
begin
  blnFilCom := Value;

  If (blnFilCom) Then
    cdsProAti.AfterScroll := pAfterScrollProAti
  Else
    cdsProAti.AfterScroll := Nil;
end;

procedure TComVen.setFilSim(Value: Boolean);
begin
  blnFilSim := Value;

  If (blnFilSim) Then
    cdsProCom.AfterScroll := pAfterScrollProCom
  Else
    cdsProCom.AfterScroll := Nil;

end;

procedure TComVen.setIncAti(Value: Integer);
begin
  intIncAti := Value;
end;

procedure TComVen.setIncCom(Value: Integer);
begin
  intIncCom := Value;
end;

procedure TComVen.setLinGru(Value: String);
begin
  strLinGru := Value;
end;

procedure TComVen.setMsgCom(Value: String);
begin
  strMsgCom := Value;
end;

procedure TComVen.setOperad(Value: String);
begin
  strOperad := Value;
end;

procedure TComVen.setQtdIte(Value: Double);
begin
  fltQtdIte := Value;
end;

procedure TComVen.setRefere(Value: String);
begin
  strRefere := Value;
end;

procedure TComVen.setTabIte(Value: String);
begin
  strTabIte := Value;
end;

procedure TComVen.setTabPre(Value: String);
begin
  strTabPre := Value;
end;

procedure TComVen.setTipDes(Value: String);
begin
  strTipDes := Value;
end;

procedure TComVen.setTipEle(Value: TTipEle);
begin
  tipTipEle := Value;
end;

procedure TComVen.setTipPro(Value: TTipProCombo);
begin
  tipTipPro := Value;
end;

procedure TComVen.setValDes(Value: Double);
begin
  fltValDes := Value;
end;

procedure TComVen.setTabPre(Value: TCheckListBox);
begin
  clbTabPre := Value;
end;

end.
