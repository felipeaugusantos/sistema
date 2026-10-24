unit ImportacaoDados.Controller.ImportarCadLocEqu;

interface

uses
  Classes, SysUtils, untTValidaExcel, cxProgressBar, System.Generics.Collections, DB, Uni, Variants,
  ImportacaoDados.Interfaces,  ImportacaoDados.Controller.CadLocEqu, ImportacaoDados.Model.ImportacaoArquivo,
  ImportacaoDados.Model.CadLocEqu, cadastro.Model.EquipamentoLocacao, untTypesSistema;


Type
  TValidacaoDadosImportacaoCadLocEqu = class;

  TImportaPlanilhaCadLocEqu = class(TImportaPlanilha)
  private
    function fInserir: Boolean;
    function fRetornaSQLInsertCadLocEqu: String;
    function fRetornaSQLInsertEquAcl: String;
    function fRetornaSQLInsertEquNgd: String;
    procedure pInserirCadEql;
    procedure pInserirEquAcl;
    procedure pInserirEquNgd;
    function fRetornaSeqEql(strCodEql: String): String;
  public
    constructor Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction); override;
    destructor Destroy; override;
    function fInserirCadastros: Boolean; override;
  End;

  TValidacaoDadosImportacaoCadLocEqu =  Class(TValidacaoDadosImportacao)
  private
    FIndiceCodEql: Integer;
    FIndiceStatus: Integer;
    FIndiceDescri: Integer;
    FIndiceNSerie: Integer;
    FIndiceDtaAqu: Integer;
    FIndiceDtUlMn: Integer;
    FIndiceValAqu: Integer;
    FIndiceValLoc: Integer;
    FIndiceVlLocD: Integer;
    FIndiceVlLocM: Integer;
    FIndiceRpUlMn: Integer;
    FIndiceGarant: Integer;
    FIndiceAnoFab: Integer;
    FIndiceModelo: Integer;
    FIndiceDtaVen: Integer;
    FIndiceLocFis: Integer;
    FIndiceCodIte: Integer;
    FIndiceEspecf: Integer;
    FIndiceDscGer: Integer;
    FIndiceDscSge: Integer;
    FIndiceDscVen: Integer;
    FIndiceVlrCau: Integer;

    FIndiceCodEqu: Integer;
    FIndiceCodAcl: Integer;
    FIndiceQtdAcl: Integer;
    FIndiceSeqEql: Integer;
    FIndiceSeqAcl: Integer;

    FIndiceCodEquN: Integer;
    FIndiceQtdDiaN: Integer;
    FIndiceVlrTotN: Integer;
    FIndiceVlrDiaN: Integer;

    FCadEquLocacaoController:  TCadEquLocacaoController;
    FListaCodEql: TStringList;

    function fValidarRegistoDuplicadoArquivo(Const aConteudo: String): Boolean;
    function fValidarRegistoDuplicadoDB(Const aConteudo: String): Boolean;
    procedure pSetarDados(Const aLinha: ILinha);
    procedure pSetarDadosAcessorios(const aLinha: ILinha);
    procedure pSetarDadosNegociacao(const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCodIte(const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCodEql(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaVlrLoc(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaAcessorios(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaNegociacao(Const aLinha: ILinha);
  public
    constructor Create(aArquivoImportacao: IImportaPlanilha); override;
    destructor Destroy; override;
    function fValidarLinha(Const aLinha: ILinha): Boolean; override;
    procedure pLimpar; override;
    procedure pAtualizarParametrosValidacao; override;
  End;

implementation

uses
  untFuncoesSimples, StrUtils;

{ TImportaPlanilhaCadLocEqu }

constructor TImportaPlanilhaCadLocEqu.Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction);
begin
  inherited;

  Valida := TValidacaoDadosImportacaoCadLocEqu.Create(Self);
end;

destructor TImportaPlanilhaCadLocEqu.Destroy;
begin

  inherited;

end;

function TImportaPlanilhaCadLocEqu.fInserir: Boolean;
begin
  fStartTransaction;
  Try
    pInserirCadEql;
    pInserirEquAcl;
    pInserirEquNgd;
    fCommit;
    Result := True;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message,'[TImportaPlanilhaCadLocEqu.Inserir]');
    End;
  End;
end;

function TImportaPlanilhaCadLocEqu.fInserirCadastros: Boolean;
begin
  Try
    Result := fInserir;
  Except
    Result := False;
  End;
end;

function TImportaPlanilhaCadLocEqu.fRetornaSeqEql(strCodEql: String): String;
begin
  Result := fCampoTabela('AUTOINCREM', 'CADEQL', ['EQL_CODIGO'], [strCodEql]);
end;

function TImportaPlanilhaCadLocEqu.fRetornaSQLInsertCadLocEqu: String;
var
  intCnt: Integer;
  strCampos, strVlues: String;
begin
  strCampos := 'AUTOINCREM';
  strVlues  := ':AUTOINCREM';
  For intCnt := 0 to Modelo.Campos.Count-1 do
  Begin
    If (Pos('EQL_', Modelo.Campos[intCnt].NomeCampo) > 0) Then
    Begin
      strCampos := strCampos + ', ' + Modelo.Campos[intCnt].NomeCampo;
      strVlues := strVlues + ', ' + ':' + Modelo.Campos[intCnt].NomeCampo;
    End;
  End;

  Result := 'INSERT INTO CADEQL( ' + strCampos +' ) '+
            'VALUES( ' + strVlues + ' )';
end;

function TImportaPlanilhaCadLocEqu.fRetornaSQLInsertEquAcl: String;
var
  intCnt, intCont: Integer;
  strCampos, strVlues: String;
  ModeloEqlAce: IModeloArquivoImportacao;
begin
  strCampos := 'AUTOINCREM, EQA_CODIGO';
  strVlues  := ':AUTOINCREM, :EQA_CODIGO';
  For intCont := 0 To Modelo.ListaModeloTabelas.Count-1 Do
  Begin
    ModeloEqlAce := Modelo.ListaModeloTabelas[intCont];
    If ModeloEqlAce.strNomTabela = cstTabAce Then
    Begin
      For intCnt := 0 to ModeloEqlAce.Campos.Count-1 do
      Begin
        If (Pos('EQA_', ModeloEqlAce.Campos[intCnt].NomeCampo) > 0) Then
        Begin
          strCampos := strCampos + ', ' + ModeloEqlAce.Campos[intCnt].NomeCampo;
          strVlues := strVlues + ', ' + ':' + ModeloEqlAce.Campos[intCnt].NomeCampo;
        End;
      End;
    End;
  End;

  Result := 'INSERT INTO EQUACL(' + strCampos +' ) '+
            'VALUES(' + strVlues + ' )';
end;

function TImportaPlanilhaCadLocEqu.fRetornaSQLInsertEquNgd: String;
var
  intCnt, intCont: Integer;
  strCampos, strVlues: String;
  ModeloNegociacao: IModeloArquivoImportacao;
begin
  strCampos := 'AUTOINCREM, EQN_CODIGO';
  strVlues  := ':AUTOINCREM, :EQN_CODIGO';
  For intCont := 0 To Modelo.ListaModeloTabelas.Count-1 Do
  Begin
    ModeloNegociacao := Modelo.ListaModeloTabelas[intCont];
    If ModeloNegociacao.strNomTabela = cstTabNeg Then
    Begin
      For intCnt := 0 to ModeloNegociacao.Campos.Count-1 do
      Begin
        If (Pos('EQN_', ModeloNegociacao.Campos[intCnt].NomeCampo) > 0) Then
        Begin
          strCampos := strCampos + ', ' + ModeloNegociacao.Campos[intCnt].NomeCampo;
          strVlues := strVlues + ', ' + ':' + ModeloNegociacao.Campos[intCnt].NomeCampo;
        End;
      End;
    End;
  End;

  Result := 'INSERT INTO EQUNGD(' + strCampos +' ) '+
            'VALUES(' + strVlues + ' )';
end;

procedure TImportaPlanilhaCadLocEqu.pInserirCadEql;
var
  xAutInt: String;
  FQry: TUniQuery;
  intCnt,
  intCont: Integer;
  xLinha: ILinha;
begin
  FQry := fCriaQuery(nil);
  Try
    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(fRetornaSQLInsertCadLocEqu);
    FQry.Prepare;

    For intCnt := 0 to LinhasImportadas.Count-1 do
    Begin
      xLinha := LinhasImportadas[intCnt];
      If xLinha.strNomeTabela = cstCadEql Then
      Begin
        For intCont := 0 To xLinha.Campos.Count -1 Do
        Begin
          If Pos('EQL_CODIGO', xLinha.Campos[intCont].Propriedades.NomeCampo) > 0 Then
          Begin
            If fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo) Then
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := fAtualizaProCod('CADEQL', 'EQL_CODIGO')
            Else
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := xLinha.Campos[intCont].Propriedades.Conteudo;
          End

          Else If Pos('EQL_', xLinha.Campos[intCont].Propriedades.NomeCampo) > 0 Then
          Begin
            If fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo) Then
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).Value := null
            Else
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := xLinha.Campos[intCont].Propriedades.Conteudo;
          End;
        End;
        xAutInt := fRetAutoIncrem(cstCadEql, VS_strCodEmp);
        FQry.ParamByName('AUTOINCREM').AsString := xAutInt;
        FQry.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(FQry);
  End;
end;

procedure TImportaPlanilhaCadLocEqu.pInserirEquAcl;
var
  xAutInt: String;
  FQry: TUniQuery;
  intCnt,
  intCont: Integer;
  xLinha: ILinha;
  xCodAcl: String;
  strCodEql: String;
begin
  FQry := fCriaQuery(nil);
  Try
    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(fRetornaSQLInsertEquAcl);
    FQry.Prepare;

    For intCnt := 0 to LinhasImportadas.Count-1 do
    Begin
      xLinha := LinhasImportadas[intCnt];
      If xLinha.strNomeTabela = cstTabAce Then
      Begin
        For intCont := 0 To xLinha.Campos.Count -1 Do
        Begin
          If Pos('EQA_', xLinha.Campos[intCont].Propriedades.NomeCampo) > 0 Then
          Begin
            If xLinha.Campos[intCont].Propriedades.NomeCampo = cstCodEql Then
              strCodEql := xLinha.Campos[intCont].Propriedades.Conteudo;

            If xLinha.Campos[intCont].Propriedades.NomeCampo = cstSeqEql Then
            Begin
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := IIF(fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo),
                                                                                              fRetornaSeqEql(strCodEql),
                                                                                              xLinha.Campos[intCont].Propriedades.Conteudo);
            End
            Else
            Begin
              If fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo) Then
                FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).Value := null
              Else
                FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := xLinha.Campos[intCont].Propriedades.Conteudo;
            End;
          End;
        End;
        xAutInt := fRetAutoIncrem(cstTabAce, VS_strCodEmp);
        xCodAcl := fAtualizaProCod(cstTabAce, 'EQA_CODIGO');
        FQry.ParamByName('AUTOINCREM').AsString := xAutInt;
        FQry.ParamByName('EQA_CODIGO').AsString := xCodAcl;
        FQry.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(FQry);
  End;
end;

procedure TImportaPlanilhaCadLocEqu.pInserirEquNgd;
var
  xAutInt: String;
  FQry: TUniQuery;
  intCnt,
  intCont: Integer;
  xLinha: ILinha;
  xCodNeg: String;
  strCodEql: String;
begin
  FQry := fCriaQuery(nil);
  Try
    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(fRetornaSQLInsertEquNgd);
    FQry.Prepare;

    For intCnt := 0 to LinhasImportadas.Count-1 do
    Begin
      xLinha := LinhasImportadas[intCnt];
      If xLinha.strNomeTabela = cstTabNeg Then
      Begin
        For intCont := 0 To xLinha.Campos.Count -1 Do
        Begin
          If Pos('EQN_', xLinha.Campos[intCont].Propriedades.NomeCampo) > 0 Then
          Begin
            If xLinha.Campos[intCont].Propriedades.NomeCampo = cstCodEqu Then
              strCodEql := xLinha.Campos[intCont].Propriedades.Conteudo;

            If xLinha.Campos[intCont].Propriedades.NomeCampo = cstSeqEqlN Then
            Begin
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := IIF(fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo), fRetornaSeqEql(strCodEql), xLinha.Campos[intCont].Propriedades.Conteudo);
            End
            Else
            Begin
              If fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo) Then
                FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).Value := null
              Else
                FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := xLinha.Campos[intCont].Propriedades.Conteudo;
            End;
          End;
        End;
        xAutInt := fRetAutoIncrem(cstTabNeg, VS_strCodEmp);
        xCodNeg := fAtualizaProCod(cstTabNeg, 'EQN_CODIGO');
        FQry.ParamByName('AUTOINCREM').AsString := xAutInt;
        FQry.ParamByName('EQN_CODIGO').AsString := xCodNeg;
        FQry.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(FQry);
  End;
end;

{ TValidacaoDadosImportacaoCadLocEqu }

constructor TValidacaoDadosImportacaoCadLocEqu.Create(
  aArquivoImportacao: IImportaPlanilha);
begin
  inherited;

  FCadEquLocacaoController := TCadEquLocacaoController.Create;
  FListaCodEql := TStringList.Create;
end;

destructor TValidacaoDadosImportacaoCadLocEqu.Destroy;
begin

  inherited;

  FreeAndNil(FCadEquLocacaoController);
  FreeAndNil(FListaCodEql);
end;

function TValidacaoDadosImportacaoCadLocEqu.fValidarLinha(
  const aLinha: ILinha): Boolean;
begin
  Result := True;

  Try
    If aLinha.blnTabelaPrincipal Then
    Begin
      pSetarDados(aLinha);
      pAnalisaInconsistenciaCodEql(aLinha);
      pAnalisaInconsistenciaCodIte(aLinha);
      pAnalisaInconsistenciaVlrLoc(aLinha);
    End
    Else
    Begin
      If aLinha.strNomeTabela = cstTabAce Then
      Begin
        pSetarDadosAcessorios(aLinha);
        pAnalisaInconsistenciaAcessorios(aLinha);
      End
      Else If aLinha.strNomeTabela = cstTabNeg Then
      Begin
        pSetarDadosNegociacao(aLinha);
        pAnalisaInconsistenciaNegociacao(aLinha);
      End;
    End;

    inherited;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TValidacaoDadosImportacaoCadLocEqu.fValidarLinha]');
    End;
  End;
end;

function TValidacaoDadosImportacaoCadLocEqu.fValidarRegistoDuplicadoArquivo(
  const aConteudo: String): Boolean;
var
  intCnt: Integer;
begin
  Result := True;

  If fEmptyStr(aConteudo) Then
    Exit;

  For intCnt := 0 to FListaCodEql.Count-1 Do
  Begin
    If FListaCodEql[intCnt].Equals(aConteudo) Then
    Begin
      Result := False;
      Break;
    End;
  End;

  If Result Then
    FListaCodEql.Add(aConteudo);
end;

function TValidacaoDadosImportacaoCadLocEqu.fValidarRegistoDuplicadoDB(
  const aConteudo: String): Boolean;
var
  strCodEqlC: String;
begin
  Result := True;

  If fEmptyStr(aConteudo) Then
  Begin
    Exit;
  End;

  strCodEqlC := fCampoTabela('EQL_CODIGO', 'CADEQL', ['EQL_CODIGO'], [aConteudo] );
  If (Not fEmptyStr(strCodEqlC)) Then
  Begin
    Result := False;
  End;
end;

procedure TValidacaoDadosImportacaoCadLocEqu.pAnalisaInconsistenciaAcessorios(
  const aLinha: ILinha);
var
  intCnt: Integer;
  xCampoLinhaAux: TCampoPlanilha;
  strAux: String;
begin
  strAux := fRetornaCampoCodigo(fTiraCaracEspeciaisPonto(aLinha.Campos[FIndiceCodAcl].Propriedades.Conteudo), aLinha.Campos[FIndiceCodAcl].Propriedades.Tamanho);
  For intCnt:=0 To FCadEquLocacaoController.EquipamentoLocacao.Acessorios.Count-1 Do
  Begin
    If FCadEquLocacaoController.EquipamentoLocacao.Acessorios[intCnt].Acessorio.Codigo = strAux Then
    Begin
      If Not(FCadEquLocacaoController.EquipamentoLocacao.Acessorios[intCnt].Acessorio.fValidaAcessorio)  Then
      Begin
        fAdicionaInconsistenciaLista(aLinha,
                                     aLinha.Campos[FIndiceCodAcl].Propriedades.Coluna,
                                     aLinha.Campos[FIndiceCodAcl].Propriedades.DescricaoCampo,
                                     'Cód. Acessório: '+ FCadEquLocacaoController.EquipamentoLocacao.Acessorios[intCnt].Acessorio.Codigo + ' - '+
                                     FCadEquLocacaoController.EquipamentoLocacao.Acessorios[intCnt].Acessorio.Mensagem);
      End;

      xCampoLinhaAux := aLinha.Campos[FIndiceCodAcl].Propriedades;
      xCampoLinhaAux.Conteudo := FCadEquLocacaoController.EquipamentoLocacao.Acessorios[intCnt].Acessorio.Codigo;
      aLinha.Campos[FIndiceCodAcl].Propriedades := xCampoLinhaAux;

      xCampoLinhaAux := aLinha.Campos[FIndiceCodEql].Propriedades;
      xCampoLinhaAux.Conteudo := FCadEquLocacaoController.EquipamentoLocacao.Codigo;
      aLinha.Campos[FIndiceCodEqu].Propriedades := xCampoLinhaAux;

      xCampoLinhaAux := aLinha.Campos[FIndiceSeqEql].Propriedades;
      xCampoLinhaAux.Conteudo := FCadEquLocacaoController.EquipamentoLocacao.AutInc;
      aLinha.Campos[FIndiceSeqEql].Propriedades := xCampoLinhaAux;

      xCampoLinhaAux := aLinha.Campos[FIndiceSeqAcl].Propriedades;
      xCampoLinhaAux.Conteudo := FCadEquLocacaoController.EquipamentoLocacao.Acessorios[intCnt].Acessorio.AutInc;
      aLinha.Campos[FIndiceSeqAcl].Propriedades := xCampoLinhaAux;
    End;
  End;
end;

procedure TValidacaoDadosImportacaoCadLocEqu.pAnalisaInconsistenciaCodEql(
  const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FCadEquLocacaoController.EquipamentoLocacao.Codigo) Then
    Exit;

  If aLinha.Campos[FIndiceCodEql].Propriedades.blnTabela Then
    Exit;

  If Not(fValidarRegistoDuplicadoDB(FCadEquLocacaoController.EquipamentoLocacao.Codigo))  Then
  Begin
    fAdicionaInconsistenciaLista(aLinha,
                                 aLinha.Campos[FIndiceCodEql].Propriedades.Coluna,
                                 aLinha.Campos[FIndiceCodEql].Propriedades.DescricaoCampo,
                                 cstValidacaoRegistroDuplicadoDB);
  End;

  If Not(fValidarRegistoDuplicadoArquivo(FCadEquLocacaoController.EquipamentoLocacao.Codigo))  Then
  Begin
    fAdicionaInconsistenciaLista(aLinha,
                                 aLinha.Campos[FIndiceCodEql].Propriedades.Coluna,
                                 aLinha.Campos[FIndiceCodEql].Propriedades.DescricaoCampo,
                                 cstValidacaoRegistroDuplicadoArq);
  End;

  xCampoLinhaAux := aLinha.Campos[FIndiceCodEql].Propriedades;
  xCampoLinhaAux.Conteudo := FCadEquLocacaoController.EquipamentoLocacao.Codigo;
  aLinha.Campos[FIndiceCodEql].Propriedades := xCampoLinhaAux;
End;

procedure TValidacaoDadosImportacaoCadLocEqu.pAnalisaInconsistenciaCodIte(
  const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If aLinha.Campos[FIndiceCodEql].Propriedades.blnTabela Then
    Exit;

  If Not FCadEquLocacaoController.Validacao.fValidarCodIte Then
  Begin
    fAdicionaInconsistenciaLista(aLinha,
                                 aLinha.Campos[FIndiceCodIte].Propriedades.Coluna,
                                 aLinha.Campos[FIndiceCodIte].Propriedades.DescricaoCampo,
                                 FCadEquLocacaoController.Validacao.MensagemRetorno);
  End;

  xCampoLinhaAux := aLinha.Campos[FIndiceCodIte].Propriedades;
  xCampoLinhaAux.Conteudo := FCadEquLocacaoController.EquipamentoLocacao.CodigoItem;
  aLinha.Campos[FIndiceCodIte].Propriedades := xCampoLinhaAux;
End;

procedure TValidacaoDadosImportacaoCadLocEqu.pAnalisaInconsistenciaNegociacao(
  const aLinha: ILinha);
var
  intCnt: Integer;
  xCampoLinhaAux: TCampoPlanilha;
begin
  xCampoLinhaAux := aLinha.Campos[FIndiceCodEquN].Propriedades;
  xCampoLinhaAux.Conteudo := FCadEquLocacaoController.EquipamentoLocacao.Codigo;
  aLinha.Campos[FIndiceCodEquN].Propriedades := xCampoLinhaAux;

  For intCnt:=0 To FCadEquLocacaoController.EquipamentoLocacao.Diarias.Count-1 Do
  Begin
    If FCadEquLocacaoController.EquipamentoLocacao.Diarias[intCnt].ValorTotal = StrToFloatDef(aLinha.Campos[FIndiceVlrTotN].Propriedades.Conteudo,0) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceVlrDiaN].Propriedades;
      xCampoLinhaAux.Conteudo := FloatToStr(FCadEquLocacaoController.EquipamentoLocacao.Diarias[intCnt].ValorDiaria);
      aLinha.Campos[FIndiceVlrDiaN].Propriedades := xCampoLinhaAux;
    End;
  End;
end;

procedure TValidacaoDadosImportacaoCadLocEqu.pAnalisaInconsistenciaVlrLoc(
  const aLinha: ILinha);
Begin
  If aLinha.Campos[FIndiceCodEql].Propriedades.blnTabela Then
    Exit;

  If Not FCadEquLocacaoController.Validacao.fValidarValorLocacao Then
  Begin
    fAdicionaInconsistenciaLista(aLinha,
                                 aLinha.Campos[FIndiceValLoc].Propriedades.Coluna,
                                 aLinha.Campos[FIndiceValLoc].Propriedades.DescricaoCampo,
                                 FCadEquLocacaoController.Validacao.MensagemRetorno);
    fAdicionaInconsistenciaLista(aLinha,
                                 aLinha.Campos[FIndiceVlLocD].Propriedades.Coluna,
                                 aLinha.Campos[FIndiceVlLocD].Propriedades.DescricaoCampo,
                                 FCadEquLocacaoController.Validacao.MensagemRetorno);
    fAdicionaInconsistenciaLista(aLinha,
                                 aLinha.Campos[FIndiceVlLocM].Propriedades.Coluna,
                                 aLinha.Campos[FIndiceVlLocM].Propriedades.DescricaoCampo,
                                 FCadEquLocacaoController.Validacao.MensagemRetorno);
  End;
End;

procedure TValidacaoDadosImportacaoCadLocEqu.pAtualizarParametrosValidacao;
begin
  inherited;

end;

procedure TValidacaoDadosImportacaoCadLocEqu.pLimpar;
begin
  inherited;

  FListaCodEql.Clear;
  FCadEquLocacaoController.EquipamentoLocacao.pLimpar;
  FCadEquLocacaoController.EquipamentoLocacao.pLimparItens;
  FCadEquLocacaoController.EquipamentoLocacao.pLimparDiarias;
end;

procedure TValidacaoDadosImportacaoCadLocEqu.pSetarDados(const aLinha: ILinha);
var
  intCnt: Integer;
  indice: Integer;
  strCodAux: String;
begin
  For intCnt := aLinha.Campos.Count-1 DownTo 0 Do
  Begin
    If Not aLinha.Campos[intCnt].Propriedades.blnTabela Then
    Begin
      indice :=AnsiIndexStr(aLinha.Campos[intCnt].Propriedades.NomeCampo, arrCamposCadLocEqu);

      Case indice  Of
        0 : Begin
              FIndiceCodEql := aLinha.Campos[intCnt].Propriedades.Posicao;
              If fEmptyStr(aLinha.Campos[intCnt].Propriedades.Conteudo) Then
                strCodAux := fAtualizaProCod(cstCadEql, '')
              Else
                strCodAux := fRetornaCampoCodigo(fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), aLinha.Campos[intCnt].Propriedades.Tamanho);

              FCadEquLocacaoController.EquipamentoLocacao.Codigo := strCodAux;
            End;
        1 : Begin
              FIndiceStatus := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.Status := fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo);
            End;
        2 : Begin
              FIndiceDescri := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.Descricao := fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo);
            End;
        3 : Begin
              FIndiceNSerie := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.NumSerie := fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo);
            End;
        4 : Begin
              FIndiceDtaAqu := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.DataAquisicao := StrToDateTimeDef(aLinha.Campos[intCnt].Propriedades.Conteudo,0);
            End;
        5 : Begin
              FIndiceDtUlMn := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.DataUltimaManutencao := StrToDateTimeDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
        6 : Begin
              FIndiceValAqu := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorAquisicao := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
        7 : Begin
              FIndiceValLoc := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorLocacao := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
        8 : Begin
              FIndiceVlLocD := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorLocacaoDiaria := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
        9 : Begin
              FIndiceVlLocM := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorLocacaoMensal := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
       10 : Begin
              FIndiceRpUlMn := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ResponsavelUltimaManutencao := fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo);
            End;
       11 : Begin
              FIndiceGarant := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.Garantia := StrToIntDef(aLinha.Campos[intCnt].Propriedades.Conteudo, 0);
            End;
       12 : Begin
              FIndiceAnoFab := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.AnoFabricacao := StrToIntDef(aLinha.Campos[intCnt].Propriedades.Conteudo, 0);
            End;
       13 : Begin
              FIndiceModelo := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.Modelo := aLinha.Campos[intCnt].Propriedades.Conteudo;
            End;
       14 : Begin
              FIndiceDtaVen := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.DataVenda := StrToDateTimeDef( aLinha.Campos[intCnt].Propriedades.Conteudo, 0);
            End;
       15 : Begin
              FIndiceLocFis := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.LocalizacaoFisica := aLinha.Campos[intCnt].Propriedades.Conteudo;
            End;
       16 : Begin
              FIndiceCodIte := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.CodigoItem := fRetornaCampoCodigo(fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), aLinha.Campos[intCnt].Propriedades.Tamanho);
            End;
       17 : Begin
              FIndiceEspecf := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.Especificacao := aLinha.Campos[intCnt].Propriedades.Conteudo ;
            End;
       18 : Begin
              FIndiceDscGer := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorDescontoGerente := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
       19 : Begin
              FIndiceDscSge := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorDescontoSubGerente := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
       20 : Begin
              FIndiceDscVen := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorDescontoVendedor := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
       21 : Begin
              FIndiceVlrCau := aLinha.Campos[intCnt].Propriedades.Posicao;
              FCadEquLocacaoController.EquipamentoLocacao.ValorCaucao := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
            End;
      End;
    End;
  End;
end;

procedure TValidacaoDadosImportacaoCadLocEqu.pSetarDadosAcessorios(
  const aLinha: ILinha);
var
  intCnt: Integer;
  indice: Integer;
  itemAcessorio: TEquipamentoItemAcessorio;
  strAux: String;
begin
  itemAcessorio := FCadEquLocacaoController.EquipamentoLocacao.AddItem;

  For intCnt := 0 To aLinha.Campos.Count-1 Do
  Begin
    indice :=AnsiIndexStr(aLinha.Campos[intCnt].Propriedades.NomeCampo, arrCamposEquAcl);

    Case indice  Of
      0 : Begin
            FIndiceCodEqu := aLinha.Campos[intCnt].Propriedades.Posicao;
          End;
      1 : Begin
            FIndiceCodAcl := aLinha.Campos[intCnt].Propriedades.Posicao;
            strAux := fRetornaCampoCodigo(fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), aLinha.Campos[intCnt].Propriedades.Tamanho);
            itemAcessorio.Acessorio.pCarregaEquipamento('', strAux);
          End;
      2 : Begin
            FIndiceQtdAcl := aLinha.Campos[intCnt].Propriedades.Posicao;
            itemAcessorio.Quantidade := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
          End;
      3 : Begin
            FIndiceSeqEql := aLinha.Campos[intCnt].Propriedades.Posicao;
          End;
      4 : Begin
            FIndiceSeqAcl := aLinha.Campos[intCnt].Propriedades.Posicao;
          End;
    End;
  End;
end;

procedure TValidacaoDadosImportacaoCadLocEqu.pSetarDadosNegociacao(
  const aLinha: ILinha);
var
  intCnt: Integer;
  indice: Integer;
  itemNegociacaoDiaria: TNegociacaoDiaria;
  intQuantidadeDias: Integer;
  fltValorTotal: Double;
begin
  itemNegociacaoDiaria := FCadEquLocacaoController.EquipamentoLocacao.AddNegociacaoDiaria;
  fltValorTotal := 0;
  intQuantidadeDias := 0;

  For intCnt := aLinha.Campos.Count-1 DownTo 0 Do
  Begin
    indice :=AnsiIndexStr(aLinha.Campos[intCnt].Propriedades.NomeCampo, arrCamposNegEql);

    Case indice  Of
      0 : Begin
            FIndiceCodEquN := aLinha.Campos[intCnt].Propriedades.Posicao;
          End;
      1 : Begin
            FIndiceQtdDiaN := aLinha.Campos[intCnt].Propriedades.Posicao;
            intQuantidadeDias := StrToIntDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
          End;
      2 : Begin
            FIndiceVlrTotN := aLinha.Campos[intCnt].Propriedades.Posicao;
            fltValorTotal := StrToFloatDef( fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), 0);
          End;
    End;
  End;

  FIndiceVlrDiaN := AnsiIndexStr(cstVlrDia, arrCamposNegEql);
  itemNegociacaoDiaria.pAdicionaValorDiaria(intQuantidadeDias, fltValorTotal);
end;

end.

