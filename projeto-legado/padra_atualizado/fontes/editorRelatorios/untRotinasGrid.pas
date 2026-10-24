unit untRotinasGrid;

interface

uses
  Classes, SysUtils, Variants,
  untTypesSistema,
  Controls, StdCtrls, StrUtils,
  UniClientDataSet, UniDataSetProvider,
  BitBtnLockedIncrem,
  cxGridDBBandedTableView,
  Uni, DB, untFuncoesSimples,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  untZClient,
  Forms,
  untFuncoesRel,
  untFuncoesGenerica,
  untMapeiaParametros,
  RTTI;

Const
  INT_ESPACAMENTO_BOTAO = 1;

Type
  TTipoRotina = (tprGeraPedidoOrcamentoTE,
                 tprAbrirFormulario,
                 tprAlteraOrcamentoPedido,
                 tprNaoEncontrada);

  TTipoTarefa = (tpfRotina, tpfRelatorio);

Const
  NOMES_ROTINA: Array[tprGeraPedidoOrcamentoTE..tprAlteraOrcamentoPedido] Of String =
                 ('fGeraPedidoOrcamentoTE',
                  'fAbrirFormulario',
                  'fAlteraOrcamentoPedido');

Type
  TRotinasGrid = Class(TZClient)
  Private
    FTarefaCorrente: TTipoTarefa;
    FRotinaCorrente: TTipoRotina;
    FRelatorioCorrente: String;
    FDadosCorrente: TDataSet;

    FGrupoChamada: TGrupoChamada;
    FRotinasRelatorio: TZClient;
    FLarguraBotoes: Integer;

    FCamposRotina,
    FParametrosRotina: TZClient;

    FMultiSelecao: Boolean;

    Function fTipoToString(typTipoParametro: TFieldType): String;

    Function fSQLRotinas: String;
    Function fSQLBotoes: String;

    Function fSQLCamposRotina: String;
    Function fSQLParametrosRotina: String;

    Function fAdicionaRotina(tprRotina: TTipoRotina;
                             strDescricao,
                             strDireitoAcesso: String;
                             blnUsaClientRelatorio: Boolean): Boolean;

    Procedure pAdicionaParametroRotina(tprRotina: TTipoRotina;
                                       strNomeParametro,
                                       strDescricao: String;
                                       typTipoParametro: TFieldType);

    Procedure pAdicionaCampoRotina(tprRotina: TTipoRotina;
                                   strNomeCampo,
                                   strDescricao: String;
                                   typTipoCampo: TFieldType);

    function fGetValorParametroFiltro(strNomPar: String; typTipPar: TFieldType; blnMultiSelecaoQuoted: Boolean): Variant;
    function fGetValorCampo(strNomCam: String; typTipPar: TFieldType): Variant;
    function fGetValorMapeado(typTipPar: TFieldType; blnMultiSelecaoQuoted: Boolean): Variant;
    function fGetValorParametro(strNomPar: String; typTipPar: TFieldType; blnMultiSelecaoQuoted: Boolean = True): Variant;
    //function fGetClientRelatorio: TDataSet;

    Procedure pBotaoRotinaClick(Sender: TObject);

    function fTransferePedido: Boolean;

    function fAbrirFormulario: Boolean;
    function fAbrirFormularioNome(const strNomFrm: String): Boolean;

    Procedure pCriaCdsRotinas;
    Procedure pCarregaRotinas;

    function fStringToVariant(strValPar: String; typTipPar: TFieldType): Variant;

    function fGetDescricaoRelatorioCorrente: String;

    function fMensagemErroValorParametroFiltro(strNomPar: String): String;
    function fMensagemErroValorCampo(strNomCam: String): String;
    function fMensagemErroValorMapeado(strNomPar: String): String;
    function fMensagemErroValorParametro(strNomPar: String): String;

    function fGetValorCampoRelatorio(strNomCam: String): String;
    function fGetValorParametroFiltroRelatorio(strNomPar: String): String;
    function fGetValorMapeadoRelatorio: String;

    function fExecutaRotina: Boolean;

    Procedure pAdicionaRotinaGeraPedidoOrcamentoTE;
    Procedure pAdicionaRotinaAlteraOrcamento;
    Procedure pAdicionaRotinaAbrirFormulario;
    Function fAlteraOrcamento: Boolean;

  Public

    blnPaiEmEdicao: Boolean;

    objMapeiaParametros: TMapeiaParametros;

    objInteface: Pointer;

    constructor Create(Owner: TComponent; AGrupoChamada: TGrupoChamada);  Reintroduce;
    Destructor Destroy; override;

    function fCarregaRotinasRelatorio(strSeqGer: String): Boolean;
    function fSalvaRotinasRelatorio(strSeqGer: String): Boolean;
    function fApagaRotinasRelatorio: Boolean;
    function fIncluiRotinaRelatorio(strCodRel,
                                    strDesRel,
                                    strNomRot,
                                    strTitBot: String;
                                    intTipCha: Integer;
                                    blnCopVal,
                                    blnExeDir,
                                    blnFecSai: Boolean;
                                    strAtaRel: String): Boolean;

    Function fExisteParametro(strNomRot, strNomPar: String): Boolean;

    function fNomeRotinaToTipo(strNomRot: String): TTipoRotina;

    Procedure pCriaBotoes(frmTela: TForm; FlwBotoes: TFlowPanel; cdsDados: TDataset; comFoco: TWinControl);

    Function fValidaMapeamento: Boolean;

    Procedure pDecOrdemRotina(cxvDados: TcxGridDBBandedTableView);
    Procedure pIncOrdemRotina(cxvDados: TcxGridDBBandedTableView);

    Procedure pFiltraCamposRotina(strNomRot: String);

    Procedure pFiltraParametrosRotina(strNomRot: String);

    Function fRelatorioTemCamposDaRotina(strNomRot: String; cdsCampos: TZClient): Boolean;
    Function fValidaCamposDasRotinas(cdsCampos: TZClient): Boolean;
    Function fVerificaCamposRotina(strNomRot: String; cdsDados: TDataSet): Boolean;

    Function fRetornaStringAtalhoTeclado(Key: Word; Shift: TShiftState): String;
    Procedure pExecutaRotinaTeclaAtalho(Key: Word; Shift: TShiftState; FlwBotoes: TFlowPanel);

    Property cdsRotinasRelatorio: TZClient Read FRotinasRelatorio Write FRotinasRelatorio;
    Property cdsParametrosRotinas: TZClient Read FParametrosRotina;
    Property cdsCamposRotina: TZClient Read FCamposRotina;
    Property intLarguraBotoes: Integer Read FLarguraBotoes Write FLarguraBotoes;
    property tpcGrupoChamada: TGrupoChamada Read FGrupoChamada;
    property strRelatorioCorrente: String Read FRelatorioCorrente Write FRelatorioCorrente;
  End;

  TBotaoRotina = Class(TBitBtnLocked)
    private

      FRotina: TTipoRotina;

      FCodRel,
      FSeqRel: String;

      FCopiaDadosPai,
      FExecutaBotaoDireto: Boolean;

      FDados: TDataSet;
      FTeclaAtalho: String;

    public

      objInteface: Pointer;

      objBotoes: TRotinasGrid;

      comComponenteFoco: TWinControl;

      frmFormPai: TForm;

      arrParametrosBotao,
      arrValoresBotao: Array Of String;

      arrParametrosReadOnly,
      arrParametrosInvisiveis: TArrString;

      objRetornoRelatorio: TRetornoRelatorio;

      Function fCarregaParametrosBotaoRelatorio: Boolean;

      constructor Create(AOwner: TComponent; ARotina: TTipoRotina; ADados: TDataSet);  Reintroduce;

      Class Function fRetornaBotaoRotina(FlowPanel: TFlowPanel; const strTeclaAtalho: string): TBotaoRotina;

      destructor Destroy; override;

    published
      property tprRotina: TTipoRotina Read FRotina;
      property strCodRel: String Read FCodRel Write FCodRel;
      property strSeqRel: String Read FSeqRel Write FSeqRel;
      property blnCopiaDadosPai: Boolean Read FCopiaDadosPai Write FCopiaDadosPai;
      property blnExecutaBotaoDireto: Boolean Read FExecutaBotaoDireto Write FExecutaBotaoDireto;
      property cdsDados: TDataSet Read FDados Write FDados;
      property strTeclaAtalho: String Read FTeclaAtalho Write FTeclaAtalho;
  End;

implementation

Uses
  TypInfo,
  untConstantes,
  untInterfaceRelatorio,
  untGridRelatResult,
  untRelGeraOr;

Const
  UsaClientRelatorio = True;

constructor TRotinasGrid.Create(Owner: TComponent; AGrupoChamada: TGrupoChamada);
Begin
  Inherited Create(Owner);

  blnPaiEmEdicao := False;

  FGrupoChamada := AGrupoChamada;

  objInteface := Nil;

  pCriaCdsRotinas;

  FRotinasRelatorio := TZClient.Create(Self, fSQLBotoes);
  FRotinasRelatorio.pCriaSoma('ROT_ORDBOT', 'MAX_ORDBOT', 'MAX(ROT_ORDBOT)');

  objMapeiaParametros := TMapeiaParametros.Create(Self, AGrupoChamada);
  objMapeiaParametros.objRotinasGrid := Self;
End;

Destructor TRotinasGrid.Destroy;
Begin
  Inherited;

End;

Function TRotinasGrid.fSQLCamposRotina: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(255)) AS NOMROT, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS NOMCAM, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(255)) AS DESCAM, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS TIPCAM  ';
  strSQL := strSQL + ' ';
  Result := strSQL;
End;

Function TRotinasGrid.fSQLParametrosRotina: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(255)) AS NOMROT, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS NOMPAR, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(255)) AS DESPAR, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS TIPPAR  ';
  strSQL := strSQL + ' ';
  Result := strSQL;
End;

Function TRotinasGrid.fAdicionaRotina(tprRotina: TTipoRotina;
                                      strDescricao,
                                      strDireitoAcesso: String;
                                      blnUsaClientRelatorio: Boolean): Boolean;
Begin
  Result := False;

  If blnUsaClientRelatorio And (FGrupoChamada = tpcTelaFiltros) Then
    Exit;

  Self.Append;
  Self.FieldByName('NOMROT').AsString := String(NOMES_ROTINA[tprRotina]);
  Self.FieldByName('DESROT').AsString := strDescricao;
  Self.FieldByName('DIRACE').AsString := strDireitoAcesso;
  Self.FieldByName('DIRACE').AsString := IIF(blnUsaClientRelatorio, 'S', 'N');

  Self.Post;

  Result := True;
End;

Procedure TRotinasGrid.pAdicionaParametroRotina(tprRotina: TTipoRotina;
                                                strNomeParametro,
                                                strDescricao: String;
                                                typTipoParametro: TFieldType);
Begin
  FParametrosRotina.Append;
  FParametrosRotina.FieldByName('NOMROT').AsString := String(NOMES_ROTINA[tprRotina]);
  FParametrosRotina.FieldByName('NOMPAR').AsString := strNomeParametro;
  FParametrosRotina.FieldByName('DESPAR').AsString := strDescricao;
  FParametrosRotina.FieldByName('TIPPAR').AsString := fTipoToString(typTipoParametro);
  FParametrosRotina.Post;
End;

Procedure TRotinasGrid.pAdicionaCampoRotina(tprRotina: TTipoRotina;
                                            strNomeCampo,
                                            strDescricao: String;
                                            typTipoCampo: TFieldType);
Begin
  FCamposRotina.Append;
  FCamposRotina.FieldByName('NOMROT').AsString := String(NOMES_ROTINA[tprRotina]);
  FCamposRotina.FieldByName('NOMCAM').AsString := strNomeCampo;
  FCamposRotina.FieldByName('DESCAM').AsString := strDescricao;
  FCamposRotina.FieldByName('TIPCAM').AsString := fTipoToString(typTipoCampo);
  FCamposRotina.Post;
End;

Procedure TRotinasGrid.pCriaCdsRotinas;
Begin
  Self.qryQuery.SQL.Text := fSQLRotinas;
  Self.IndexFieldNames := 'NOMROT';
  Self.fLeDados('TRotinasGrid.Create');
  Self.EmptyDataSet;

  FCamposRotina := TZClient.Create(Self, fSQLCamposRotina);
  FCamposRotina.IndexFieldNames := 'NOMROT;NOMCAM';
  FCamposRotina.fLeDados('TRotinasGrid.pCriaCdsRotinas');
  FCamposRotina.EmptyDataSet;

  FParametrosRotina := TZClient.Create(Self, fSQLParametrosRotina);
  FParametrosRotina.IndexFieldNames := 'NOMROT;NOMPAR';
  FParametrosRotina.fLeDados('TRotinasGrid.pCriaCdsRotinas');
  FParametrosRotina.EmptyDataSet;

  pCarregaRotinas;
End;

Function TRotinasGrid.fExisteParametro(strNomRot, strNomPar: String): Boolean;
Begin
  Result := FParametrosRotina.FindKey([strNomRot, strNomPar]);
End;

Procedure TRotinasGrid.pCarregaRotinas;
Begin
  pAdicionaRotinaAlteraOrcamento;
  pAdicionaRotinaGeraPedidoOrcamentoTE;
  pAdicionaRotinaAbrirFormulario;
End;

Function TRotinasGrid.fSQLBotoes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT    ';
  strSQL := strSQL + '   R.*,    ';
  strSQL := strSQL + '   (SELECT REL_CODREL FROM CADREL C WHERE C.AUTOINCREM = ROT_SEQREL) AS CODREL, ';
  strSQL := strSQL + '   (SELECT REL_DESCRI FROM CADREL C WHERE C.AUTOINCREM = ROT_SEQREL) AS DESROT, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(255)) AS DIRACE  ';
  strSQL := strSQL + ' FROM      ';
  strSQL := strSQL + '   RELROT R ';
  strSQL := strSQL + ' WHERE     ';
  strSQL := strSQL + '   ROT_SEQGER = :SEQGER ';

  If FGrupoChamada = tpcTelaFiltros Then
    strSQL := strSQL + '   AND ROT_GRUCHA = ' + IntToStr(INT_GRUPO_FILTROS)
  Else
    strSQL := strSQL + '   AND ROT_GRUCHA = ' + IntToStr(INT_GRUPO_GRID);

  Result := strSQL;
End;

Function TRotinasGrid.fSQLRotinas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(250)) AS NOMROT, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(250)) AS DESROT, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(200)) AS DIRACE, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(001)) AS USACLI  ';
  Result := strSQL;
End;

function TRotinasGrid.fStringToVariant(strValPar: String; typTipPar: TFieldType): Variant;
Begin
  Case typTipPar Of
    ftInteger  : Result := StrToIntDef(strValPar, -1);
    ftDate     : Result := StrToDateDef(strValPar, 0);
    ftDateTime : Result := StrToDateTimeDef(strValPar, 0);
    ftFloat    : Result := StrToFloatDef(AnsiReplaceStr(strValPar, ',', '.'), -1);
    ftString   : Result := strValPar;
    Else         Result := Null;
  End;
End;

function TRotinasGrid.fGetDescricaoRelatorioCorrente: String;
  Var
    qryDados: TUniQuery;
Begin
  qryDados := fCriaQuery;
  qryDados.SQL.Text := 'SELECT CONCAT(REL_CODREL, "-", REL_DESCRI) AS DESCRI FROM CADREL WHERE REL_CODREL = :CODREL';
  qryDados.ParamByName('CODREL').AsString := FRelatorioCorrente;
  qryDados.Open;

  Result := qryDados.FieldByName('DESCRI').AsString;

  FreeAndNil(qryDados);
End;

function TRotinasGrid.fMensagemErroValorParametroFiltro(strNomPar: String): String;
Begin
  Result := 'Versão do Relatório incompatível com o a versão do Autcom. ';
  Result := Result + 'Parâmetro de relatório (' +  strNomPar + ') não encontrado no mapeamento ';

  Case FTarefaCorrente Of
    tpfRotina   : Result := Result + ' da rotina ' + NOMES_ROTINA[FRotinaCorrente];
    tpfRelatorio: Result := Result + ' do relatório ' + fGetDescricaoRelatorioCorrente;
    Else          Result := '';
  End;

  Result := Result + '. Entre em contado com a Citel!';
End;

function TRotinasGrid.fGetValorParametroFiltro(strNomPar: String; typTipPar: TFieldType; blnMultiSelecaoQuoted: Boolean): Variant;
  Var
    strValPar: String;
    blnAchou: Boolean;
Begin
  strValPar := '';
  blnAchou := False;

  If Assigned(objInteface) Then
    strValPar := TInterfaceRelatorio(objInteface).fGetValorParametroRotinasGrid(strNomPar, blnAchou, FMultiSelecao,
                   True{blnTiraMascara}, True{blnMesmoInvisivel});

  If blnAchou Then
  Begin
    If FMultiSelecao And (Not blnMultiSelecaoQuoted) Then
      strValPar := AnsiReplaceStr(AnsiReplaceStr(strValPar, '''', ''), ', ', ',');

  End Else
  Begin
    Raise ExceptionAutcom.Create(fMensagemErroValorParametroFiltro(strNomPar));
  End;

  Result := fStringToVariant(strValPar, typTipPar);
End;

function TRotinasGrid.fMensagemErroValorCampo(strNomCam: String): String;
Begin
  Result := 'Versão do Relatório incompatível com o a versão do Autcom. ';
  Result := Result + 'Campo do relatório (' +  strNomCam + ') não encontrado no mapeamento ';

  Case FTarefaCorrente Of
    tpfRotina   : Result := Result + ' da rotina ' + NOMES_ROTINA[FRotinaCorrente];
    tpfRelatorio: Result := Result + ' do relatório ' + fGetDescricaoRelatorioCorrente;
    Else          Result := '';
  End;

  Result := Result + '. Entre em contado com a Citel!';
End;

function TRotinasGrid.fGetValorCampo(strNomCam: String; typTipPar: TFieldType): Variant;
Begin
  If Not Assigned(FDadosCorrente.FindField(strNomCam)) Then
    Raise ExceptionAutcom.Create(fMensagemErroValorCampo(strNomCam));

  Result := FDadosCorrente.FieldByName(strNomCam).Value;
End;

function TRotinasGrid.fMensagemErroValorMapeado(strNomPar: String): String;
Begin
  Result := Concat('Versão do Relatório incompatível com o a versão do Autcom. ',
                   'Parâmetro ', strNomPar, ' não mapeado para a rotina', NOMES_ROTINA[FRotinaCorrente],
                   '. Entre em contado com a Citel!');
End;

function TRotinasGrid.fGetValorMapeado(typTipPar: TFieldType; blnMultiSelecaoQuoted: Boolean): Variant;
Begin
  If Not Assigned(objMapeiaParametros) Then
    Raise ExceptionAutcom.Create('Erro interno - Mapeamento de parâmetros não carregado, entre em contado com a Citel!');

  Try
    Case objMapeiaParametros.FieldByName('MAP_TIPATR').AsInteger Of
      INT_PARAMETRO: Result := fGetValorParametroFiltro(objMapeiaParametros.FieldByName('MAP_PARPAI').AsString, typTipPar, blnMultiSelecaoQuoted);
      INT_CONSTANTE: Result := fStringToVariant(objMapeiaParametros.FieldByName('MAP_VALORC').AsString, typTipPar);
      INT_CAMPO    : Result := fGetValorCampo(objMapeiaParametros.FieldByName('MAP_NOMCAM').AsString, typTipPar);

      Else     Raise ExceptionAutcom.Create(fMensagemErroValorMapeado(objMapeiaParametros.FieldByName('MAP_NOMPAR').AsString));
    End;

  Except
    On E: Exception Do
    Begin
      Raise ExceptionAutcom.Create(fMensagemErroValorMapeado(objMapeiaParametros.FieldByName('MAP_NOMPAR').AsString));
    End;
  End;
End;

function TRotinasGrid.fGetValorCampoRelatorio(strNomCam: String): String;
Begin
  If Not Assigned(FDadosCorrente.FindField(strNomCam)) Then
    Raise ExceptionAutcom.Create(fMensagemErroValorCampo(strNomCam));

  Result := FDadosCorrente.FieldByName(strNomCam).AsString;
End;

function TRotinasGrid.fGetValorParametroFiltroRelatorio(strNomPar: String): String;
  Var
    blnAchou: Boolean;
Begin
  Result := '';

  If Assigned(objInteface) Then
    Result := TInterfaceRelatorio(objInteface).fGetValorParametro(strNomPar, blnAchou, True, True);

  If Not blnAchou Then
    Raise ExceptionAutcom.Create(fMensagemErroValorParametroFiltro(strNomPar));
End;

function TRotinasGrid.fGetValorMapeadoRelatorio: String;
Begin
  Try
    FTarefaCorrente := tpfRelatorio;

    Case objMapeiaParametros.FieldByName('MAP_TIPATR').AsInteger Of
      INT_PARAMETRO: Result := fGetValorParametroFiltroRelatorio(objMapeiaParametros.FieldByName('MAP_PARPAI').AsString);
      INT_CONSTANTE: Result := objMapeiaParametros.FieldByName('MAP_VALORC').AsString;
      INT_CAMPO    : Result := fGetValorCampoRelatorio(objMapeiaParametros.FieldByName('MAP_NOMCAM').AsString);

      Else           Raise ExceptionAutcom.Create(fMensagemErroValorMapeado(objMapeiaParametros.FieldByName('MAP_NOMPAR').AsString));
    End;

  Except
    On E: Exception Do
    Begin
      Raise ExceptionAutcom.Create(fMensagemErroValorMapeado(objMapeiaParametros.FieldByName('MAP_NOMPAR').AsString) + #13#10 + E.Message);
    End;
  End;
End;

function TRotinasGrid.fMensagemErroValorParametro(strNomPar: String): String;
Begin
  Result := Concat('Versão do Relatório incompatível com o a versão do Autcom ',
                  '(parâmetro ', strNomPar, ' da rotina ', NOMES_ROTINA[FRotinaCorrente], ' não encontrado',
                  '. Entre em contado com a Citel!');
End;

function TRotinasGrid.fGetValorParametro(strNomPar: String; typTipPar: TFieldType; blnMultiSelecaoQuoted: Boolean = True): Variant;
Begin
  FTarefaCorrente := tpfRotina;

  If Not objMapeiaParametros.fLocalizaParametroRotina(NOMES_ROTINA[FRotinaCorrente], strNomPar) Then
    Raise ExceptionAutcom.Create(fMensagemErroValorParametro(strNomPar));

  Result := fGetValorMapeado(typTipPar, blnMultiSelecaoQuoted);
End;

{function TRotinasGrid.fGetClientRelatorio: TDataSet;
Begin
  If Not Assigned(FDadosCorrente) Then
    Raise ExceptionAutcom.Create('Dados do relatório não disponível nesse contexto! Entre em contato com a Citel!');

  Result := FDadosCorrente;
End;}

function TRotinasGrid.fCarregaRotinasRelatorio(strSeqGer: String): Boolean;
Begin
  FRotinasRelatorio.DisableControls;

  FRotinasRelatorio.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
  Result := FRotinasRelatorio.fLeDados('TRotinasGrid.fCarregaRotinasRelatorio');

  If Not Result Then
    Exit;

  FRotinasRelatorio.First;
  While Not FRotinasRelatorio.Eof Do
  Begin
    FRotinasRelatorio.Edit;

    If Self.FindKey([FRotinasRelatorio.FieldByName('ROT_NOMROT').AsString]) Then
    Begin
      FRotinasRelatorio.FieldByName('DESROT').AsString := Self.FieldByName('DESROT').AsString;
      FRotinasRelatorio.FieldByName('DIRACE').AsString := Self.FieldByName('DIRACE').AsString;
    End;

    FRotinasRelatorio.Post;

    FRotinasRelatorio.Next;
  End;

  FRotinasRelatorio.First;

  FRotinasRelatorio.EnableControls;

  Result := objMapeiaParametros.fCarregaMapeiaParametros(strSeqGer);
End;

function TRotinasGrid.fSalvaRotinasRelatorio(strSeqGer: String): Boolean;
Begin
  FRotinasRelatorio.DisableControls;
  FRotinasRelatorio.First;
  While Not FRotinasRelatorio.Eof Do
  Begin
    If FRotinasRelatorio.FieldByName('ROT_SEQGER').IsNull Then
    Begin
      FRotinasRelatorio.Edit;
      FRotinasRelatorio.FieldByName('ROT_SEQGER').AsString := strSeqGer;
      FRotinasRelatorio.Post;
    End;

    FRotinasRelatorio.Next;
  End;

  Result := FRotinasRelatorio.fSalva And
            objMapeiaParametros.fSalvaMapeiaParametros(strSeqGer);

  FRotinasRelatorio.EnableControls;
End;

function TRotinasGrid.fApagaRotinasRelatorio: Boolean;
Begin
  Result := False;
  If FRotinasRelatorio.IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão da rotina ' + FRotinasRelatorio.FieldByName('DESROT').AsString + '?') Then
  Begin
    If fEmptyStr(FRotinasRelatorio.FieldByName('ROT_SEQREL').AsString) Then
    Begin
      If Not objMapeiaParametros.fExcluiParametrosRotina(FRotinasRelatorio.FieldByName('ROT_NOMROT').AsString) Then
        Exit;
    End Else
    Begin
      If Not objMapeiaParametros.fExcluiParametrosRelatorio(FRotinasRelatorio.FieldByName('ROT_SEQREL').AsString) Then
        Exit;
    End;

    FRotinasRelatorio.Delete;
    Result := True;
  End;
End;

function TRotinasGrid.fIncluiRotinaRelatorio(strCodRel,
                                             strDesRel,
                                             strNomRot,
                                             strTitBot: String;
                                             intTipCha: Integer;
                                             blnCopVal,
                                             blnExeDir,
                                             blnFecSai: Boolean;
                                             strAtaRel: String): Boolean;
  Var
    intMax: Integer;
Begin
  Result := True;

  If (Not strNomRot.IsEmpty) And FRotinasRelatorio.Locate('ROT_NOMROT', strNomRot, []) Then
    FRotinasRelatorio.Edit

  Else If (Not strCodRel.IsEmpty) And FRotinasRelatorio.Locate('CODREL', strCodRel, []) Then
    FRotinasRelatorio.Edit

  Else
  Begin
    intMax := Trunc(FRotinasRelatorio.fRetSoma('MAX_ORDBOT'));

    FRotinasRelatorio.Append;
    FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger := intMax;

    If strCodRel.IsEmpty Then
    Begin
      Result := objMapeiaParametros.fIncluiParametrosRotina(strNomRot);
    End Else
    Begin
      FRotinasRelatorio.FieldByName('ROT_SEQREL').AsString := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [strCodRel]);
      Result := objMapeiaParametros.fIncluiParametrosRelatorio(FRotinasRelatorio.FieldByName('ROT_SEQREL').AsString);
    End;

  End;

  If Not Result Then
  Begin
    FRotinasRelatorio.Cancel;
    Exit;
  End;

  If FGrupoChamada = tpcTelaFiltros Then
    FRotinasRelatorio.FieldByName('ROT_GRUCHA').AsInteger := INT_GRUPO_FILTROS
  Else
    FRotinasRelatorio.FieldByName('ROT_GRUCHA').AsInteger := INT_GRUPO_GRID;

  FRotinasRelatorio.FieldByName('ROT_NOMROT').AsString := strNomRot;
  FRotinasRelatorio.FieldByName('ROT_TITBOT').AsString := strTitBot;
  FRotinasRelatorio.FieldByName('ROT_TECATA').AsString := strAtaRel;

  If strCodRel.IsEmpty Then
  Begin
    If blnFecSai Then
      FRotinasRelatorio.FieldByName('ROT_FECTEL').AsString := 'S'
    Else
      FRotinasRelatorio.FieldByName('ROT_FECTEL').AsString := 'N';

    FRotinasRelatorio.FieldByName('ROT_COPPAI').AsString := 'N';
    FRotinasRelatorio.FieldByName('ROT_EXEDIR').AsString := 'N';

    If Self.FindKey([FRotinasRelatorio.FieldByName('ROT_NOMROT').AsString]) Then
    Begin
      FRotinasRelatorio.FieldByName('DESROT').AsString := Self.FieldByName('DESROT').AsString;
      FRotinasRelatorio.FieldByName('DIRACE').AsString := Self.FieldByName('DIRACE').AsString;
    End;

  End Else
  Begin
    FRotinasRelatorio.FieldByName('ROT_FECTEL').AsString := 'N';

    FRotinasRelatorio.FieldByName('DESROT').AsString := strDesRel;
    FRotinasRelatorio.FieldByName('CODREL').AsString := strCodRel;

    If blnCopVal Then
      FRotinasRelatorio.FieldByName('ROT_COPPAI').AsString := 'S'
    Else
      FRotinasRelatorio.FieldByName('ROT_COPPAI').AsString := 'N';

    If blnExeDir Then
      FRotinasRelatorio.FieldByName('ROT_EXEDIR').AsString := 'S'
    Else
      FRotinasRelatorio.FieldByName('ROT_EXEDIR').AsString := 'N';
  End;

  FRotinasRelatorio.Post;
End;

function TRotinasGrid.fNomeRotinaToTipo(strNomRot: String): TTipoRotina;
  Var
    tprContador: TTipoRotina;
Begin
  Result := tprNaoEncontrada;

  For tprContador := Low(NOMES_ROTINA) To High(NOMES_ROTINA) Do
    If SameText(strNomRot, String(NOMES_ROTINA[tprContador])) Then
    Begin
      Result := tprContador;
      Exit;
    End;
End;

Procedure TRotinasGrid.pBotaoRotinaClick(Sender: TObject);
  Var
    btnRotina: TBotaoRotina;
Begin
  Try
    btnRotina := TBotaoRotina(Sender);

    FRotinaCorrente := btnRotina.tprRotina;
    FDadosCorrente  := btnRotina.cdsDados;

    If btnRotina.strCodRel.IsEmpty Then
    Begin
      If Not fVerificaCamposRotina(NOMES_ROTINA[FRotinaCorrente], btnRotina.cdsDados) Then
        Exit;

      If Not FRotinasRelatorio.Locate('ROT_NOMROT', NOMES_ROTINA[FRotinaCorrente], []) Then
      Begin
        pMensagemOk('Erro interno. Dados da rotina não carregados!');
        Exit;
      End;

      If fExecutaRotina And
         (FRotinasRelatorio.FieldByName('ROT_FECTEL').AsString = 'S') And
         Assigned(btnRotina.frmFormPai) Then
      Begin
        If btnRotina.frmFormPai Is TfrmGridRelatResult Then
          TfrmGridRelatResult(btnRotina.frmFormPai).blnConfirmarSaida := False;
        btnRotina.frmFormPai.Close;
      End;

    End

    Else If Assigned(fncExecutaRelatorioCodigo) Then
    Begin
      If Not FRotinasRelatorio.Locate('CODREL', btnRotina.strCodRel, []) Then
      Begin
        pMensagemOk('Erro interno. Dados da relatório não carregados!');
        Exit;
      End;

      If Not btnRotina.fCarregaParametrosBotaoRelatorio Then
        Exit;

      btnRotina.objRetornoRelatorio.blnPaiEmEdicao := blnPaiEmEdicao;
      btnRotina.objRetornoRelatorio.intAlturaTela  := FRotinasRelatorio.FieldByName('ROT_ALTTEL').AsInteger;
      btnRotina.objRetornoRelatorio.intLarguraTela := FRotinasRelatorio.FieldByName('ROT_LARTEL').AsInteger;

      fncExecutaRelatorioCodigo(btnRotina.strCodRel,
                                btnRotina.arrParametrosBotao,    // arrParametros: Array Of String;
                                btnRotina.arrValoresBotao,       // arrValores: Array Of String;
                                btnRotina.arrParametrosReadOnly, // arrParametrosReadOnly: TArrString = Nil;
                                btnRotina.blnExecutaBotaoDireto, // blnExecutarDireto: Boolean = False;
                                  True,                            // blnExibirMensagem: Boolean = True;
                                '',                              // strDirAce: String = '';
                                False,                           // blnValidacao: Boolean = False
                                btnRotina.objRetornoRelatorio);

      If blnPaiEmEdicao And FRotinasRelatorio.Locate('ROT_SEQREL', btnRotina.strSeqRel, []) Then
      Begin
        FRotinasRelatorio.Edit;
        FRotinasRelatorio.FieldByName('ROT_ALTTEL').AsInteger := btnRotina.objRetornoRelatorio.intAlturaTela;
        FRotinasRelatorio.FieldByName('ROT_LARTEL').AsInteger := btnRotina.objRetornoRelatorio.intLarguraTela;
        FRotinasRelatorio.Post;
      End;

    End;

    If Assigned(btnRotina.comComponenteFoco) Then
      pSetFocus(btnRotina.comComponenteFoco)

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRotinasGrid.pBotaoRotinaClick]');
    End;
  End;

End;

Procedure TRotinasGrid.pCriaBotoes(frmTela: TForm; FlwBotoes: TFlowPanel; cdsDados: TDataset; comFoco: TWinControl);
  Var
    btnRotina: TBotaoRotina;
    tpRotina: TTipoRotina;
Begin
  FLarguraBotoes := 0;

  FRotinasRelatorio.First;

  While Not FRotinasRelatorio.Eof Do
  Begin
    tpRotina := fNomeRotinaToTipo(FRotinasRelatorio.FieldByName('ROT_NOMROT').AsString);

    btnRotina := TBotaoRotina.Create(FlwBotoes, tpRotina, cdsDados);

    btnRotina.comComponenteFoco := comFoco;
    btnRotina.frmFormPai := frmTela;
    btnRotina.objBotoes := Self;
    btnRotina.Parent  := FlwBotoes;
    btnRotina.Caption               := FRotinasRelatorio.FieldByName('ROT_TITBOT').AsString;
    btnRotina.strCodRel             := FRotinasRelatorio.FieldByName('CODREL').AsString;
    btnRotina.strSeqRel             := FRotinasRelatorio.FieldByName('ROT_SEQREL').AsString;
    btnRotina.blnCopiaDadosPai      := FRotinasRelatorio.FieldByName('ROT_COPPAI').AsString = 'S';
    btnRotina.blnExecutaBotaoDireto := FRotinasRelatorio.FieldByName('ROT_EXEDIR').AsString = 'S';
    btnRotina.strTeclaAtalho        := FRotinasRelatorio.FieldByName('ROT_TECATA').AsString;

    If (Not fEmptyStr(FRotinasRelatorio.FieldByName('DIRACE').AsString)) And
       (Not fVerificaAcessoSistema(FRotinasRelatorio.FieldByName('DIRACE').AsString)) Then
      btnRotina.Enabled := False;

    btnRotina.objInteface := objInteface;

    btnRotina.Height  := 22;
    btnRotina.Width   := frmTela.Canvas.TextWidth(btnRotina.Caption) + 16;
    btnRotina.OnClick := pBotaoRotinaClick;

    FLarguraBotoes := FLarguraBotoes + btnRotina.Width + INT_ESPACAMENTO_BOTAO;

    FRotinasRelatorio.Next;
  End;
End;

Function TRotinasGrid.fTipoToString(typTipoParametro: TFieldType): String;
Begin
  Case typTipoParametro Of
    ftInteger : Result := 'ftInteger';
    ftDate    : Result := 'ftDate';
    ftDateTime: Result := 'ftDateTime';
    ftFloat   : Result := 'ftFloat';
    Else        Result := 'ftString';
  End;
End;

Function TRotinasGrid.fValidaMapeamento: Boolean;
Begin
  Result := objMapeiaParametros.fValidaMapeamento;

  If Not Result Then
  Begin
    If fEmptyStr(objMapeiaParametros.FieldByName('MAP_NOMROT').AsString) Then
      FRotinasRelatorio.Locate('ROT_SEQREL', objMapeiaParametros.FieldByName('MAP_SEQREL').AsString, [])
    Else
      FRotinasRelatorio.Locate('ROT_NOMROT', objMapeiaParametros.FieldByName('MAP_NOMROT').AsString, []);
  End;
End;

Procedure TRotinasGrid.pDecOrdemRotina(cxvDados: TcxGridDBBandedTableView);
  Var
    strCodPar: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  strCodPar   := FRotinasRelatorio.FieldByName('ROT_TITBOT').AsString;
  intOrdAtual := FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger;

  cxvDados.NavigatorButtons.Prior.Click;

  If FRotinasRelatorio.FieldByName('ROT_TITBOT').AsString = strCodPar Then
    Exit;

  intOrdNova := FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger;
  FRotinasRelatorio.Edit;
  FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger := intOrdAtual;
  FRotinasRelatorio.Post;

  If FRotinasRelatorio.Locate('ROT_TITBOT', strCodPar, []) Then
  Begin
    FRotinasRelatorio.Edit;
    FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger := intOrdNova;
    FRotinasRelatorio.Post;
  End;
End;

Procedure TRotinasGrid.pIncOrdemRotina(cxvDados: TcxGridDBBandedTableView);
  Var
    strCodCam: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  strCodCam   := FRotinasRelatorio.FieldByName('ROT_TITBOT').AsString;
  intOrdAtual := FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger;

  cxvDados.NavigatorButtons.Next.Click;

  If FRotinasRelatorio.FieldByName('ROT_TITBOT').AsString = strCodCam Then
    Exit;

  intOrdNova := FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger;
  FRotinasRelatorio.Edit;
  FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger := intOrdAtual;
  FRotinasRelatorio.Post;

  If FRotinasRelatorio.Locate('ROT_TITBOT', strCodCam, []) Then
  Begin
    FRotinasRelatorio.Edit;
    FRotinasRelatorio.FieldByName('ROT_ORDBOT').AsInteger := intOrdNova;
    FRotinasRelatorio.Post;
  End;
End;

Procedure TRotinasGrid.pFiltraCamposRotina(strNomRot: String);
Begin
  FCamposRotina.Filter := Concat('NOMROT = ', QuotedStr(strNomRot));
  FCamposRotina.Filtered := True;
End;

Procedure TRotinasGrid.pFiltraParametrosRotina(strNomRot: String);
Begin
  FParametrosRotina.Filter := Concat('NOMROT = ', QuotedStr(strNomRot));
  FParametrosRotina.Filtered := True;
End;

constructor TBotaoRotina.Create(AOwner: TComponent; ARotina: TTipoRotina; ADados: TDataSet);
Begin
  inherited Create(AOwner);

  FRotina := ARotina;
  FDados := ADados;
  objBotoes := Nil;
  frmFormPai := Nil;

  comComponenteFoco := Nil;

  objRetornoRelatorio := TRetornoRelatorio.Create(Self);
  objRetornoRelatorio.blnExecutandoPeloBotao := True;
End;

destructor TBotaoRotina.Destroy;
Begin
  inherited;

  SetLength(arrParametrosBotao, 0);
  SetLength(arrValoresBotao, 0);
  SetLength(arrParametrosReadOnly, 0);
  SetLength(arrParametrosInvisiveis, 0);
End;

Function TBotaoRotina.fCarregaParametrosBotaoRelatorio: Boolean;
  Var
    intContador,
    intContadorReadOnly,
    intContadorInvisivel: Integer;
Begin
  Result := True;

  SetLength(arrParametrosBotao, 0);
  SetLength(arrParametrosReadOnly, 0);
  SetLength(arrParametrosInvisiveis, 0);

  If Not FCopiaDadosPai Then
    Exit;

  If Not Assigned(objBotoes) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    Try
      objBotoes.objMapeiaParametros.pFiltraParametros('', FSeqRel, True{blnApenasMapeados});

      objBotoes.strRelatorioCorrente := FCodRel;

      SetLength(arrParametrosBotao, objBotoes.objMapeiaParametros.RecordCount);
      SetLength(arrValoresBotao, Length(arrParametrosBotao));
      SetLength(arrParametrosReadOnly, Length(arrParametrosBotao));
      SetLength(arrParametrosInvisiveis, Length(arrParametrosBotao));

      intContadorReadOnly := 0;
      intContadorInvisivel := 0;
      intContador := 0;
      While Not objBotoes.objMapeiaParametros.Eof Do
      Begin
        arrParametrosBotao[intContador] := objBotoes.objMapeiaParametros.FieldByName('MAP_NOMPAR').AsString;
        arrValoresBotao[intContador]    := objBotoes.fGetValorMapeadoRelatorio;

        If SameText(objBotoes.objMapeiaParametros.FieldByName('MAP_EDITAV').AsString, 'N') Then
        Begin
          arrParametrosReadOnly[intContadorReadOnly] := objBotoes.objMapeiaParametros.FieldByName('MAP_NOMPAR').AsString;
          Inc(intContadorReadOnly);
        End;

        If SameText(objBotoes.objMapeiaParametros.FieldByName('MAP_EXIBIR').AsString, 'N') Then
        Begin
          arrParametrosInvisiveis[intContadorInvisivel] := objBotoes.objMapeiaParametros.FieldByName('MAP_NOMPAR').AsString;
          Inc(intContadorInvisivel);
        End;

        Inc(intContador);

        objBotoes.objMapeiaParametros.Next;
      End;

      SetLength(arrParametrosReadOnly, intContadorReadOnly);
      SetLength(arrParametrosInvisiveis, intContadorInvisivel);

      objRetornoRelatorio.arrParametrosInvisiveis := arrParametrosInvisiveis;
    Except
      On E: ExceptionAutcom Do
      Begin
        Result := False;
        pMensagemOk(E.Message);
      End;

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TRotinasGrid.fExecutaRotina]');
      End;
    End;

  Finally
    objBotoes.objMapeiaParametros.Filtered := False;
  End;
End;

Class function TBotaoRotina.fRetornaBotaoRotina(FlowPanel: TFlowPanel; const strTeclaAtalho: string): TBotaoRotina;
var
  i: Integer;
  Button: TBotaoRotina;
begin
  Result := nil;

  for i := 0 to FlowPanel.ControlCount - 1 do
  begin
    if FlowPanel.Controls[i] is TBotaoRotina then
    begin
      Button := TBotaoRotina(FlowPanel.Controls[i]);

      if Button.strTeclaAtalho = strTeclaAtalho then
      begin
        Result := Button;
        Exit;
      end;
    end;
  end;
end;

Function TRotinasGrid.fRelatorioTemCamposDaRotina(strNomRot: String; cdsCampos: TZClient): Boolean;
Begin
  Result := True;

  Try
    pFiltraCamposRotina(strNomRot);

    FCamposRotina.First;
    While Not FCamposRotina.Eof Do
    Begin
      If Not cdsCampos.Locate('CAM_NOMCAM', FCamposRotina.FieldByName('NOMCAM').AsString, []) Then
      Begin
        Result := False;
        pMensagemOk('Campo ' + FCamposRotina.FieldByName('NOMCAM').AsString + ' não encontrado no relatório!');
        Exit;
      End;

      FCamposRotina.Next;
    End;

  Finally
    FCamposRotina.Filtered := False;
  End;
End;

function TRotinasGrid.fRetornaStringAtalhoTeclado(Key: Word; Shift: TShiftState): String;
begin
  Result := '';

  If ssCtrl in Shift Then
    Result := Result + 'Ctrl' + ';';

  If ssShift in Shift Then
    Result := Result + 'Shift' + ';';

  If ssAlt in Shift Then
    Result := Result + 'Alt' + ';';

  If (Key.ToString() <> '16') and (Key.ToString() <> '17') and (Key.ToString() <> '18') Then
    Result := Result + Key.ToString() + ';';
end;

procedure TRotinasGrid.pExecutaRotinaTeclaAtalho(Key: Word; Shift: TShiftState; FlwBotoes: TFlowPanel);
var
  strTeclaAtalho: String;
  btnRotina: TBotaoRotina;
begin
  strTeclaAtalho := fRetornaStringAtalhoTeclado(Key, Shift);

  btnRotina := TBotaoRotina.fRetornaBotaoRotina(FlwBotoes, strTeclaAtalho);

  If Assigned(btnRotina) Then
    pBotaoRotinaClick(btnRotina);

end;

Function TRotinasGrid.fVerificaCamposRotina(strNomRot: String; cdsDados: TDataSet): Boolean;
Begin
  Result := True;

  Try
    pFiltraCamposRotina(strNomRot);

    FCamposRotina.First;
    While Not FCamposRotina.Eof Do
    Begin
      If Not Assigned(cdsDados.FindField(FCamposRotina.FieldByName('NOMCAM').AsString)) Then
      Begin
        Result := False;
        pMensagemOk('Campo ' + FCamposRotina.FieldByName('NOMCAM').AsString + ' não encontrado no relatório.' + #13#10 +
                    'Versão do sistema incompatível com o relatório.' + #13#10 + 'Entre em contado com a Citel!');
        Exit;
      End;

      FCamposRotina.Next;
    End;

  Finally
    FCamposRotina.Filtered := False;
  End;
End;

Function TRotinasGrid.fValidaCamposDasRotinas(cdsCampos: TZClient): Boolean;
Begin
  FRotinasRelatorio.DisableControls;
  Result := True;

  Try
    FRotinasRelatorio.First;
    While Not FRotinasRelatorio.Eof Do
    Begin
      If (Not fEmptyStr(FRotinasRelatorio.FieldByName('ROT_NOMROT').AsString)) And
         (Not fRelatorioTemCamposDaRotina(FRotinasRelatorio.FieldByName('ROT_NOMROT').AsString, cdsCampos)) Then
      Begin
        Result := False;
        Exit;
      End;

      FRotinasRelatorio.Next;
    End;

  Finally
    FRotinasRelatorio.EnableControls;
  End;
End;

Procedure TRotinasGrid.pAdicionaRotinaAlteraOrcamento;
Begin
  If Not fAdicionaRotina(tprAlteraOrcamentoPedido, 'Alteração de Orçamento/Pedido', '', Not UsaClientRelatorio) Then
    Exit;

  pAdicionaParametroRotina(tprAlteraOrcamentoPedido, 'strEmpresaCD', 'Empresa origem da transferência (apenas uma empresa)', ftString);
  pAdicionaParametroRotina(tprAlteraOrcamentoPedido, 'strEmpresaDestino', 'Empresa destino da transferência', ftString);
  pAdicionaParametroRotina(tprAlteraOrcamentoPedido, 'strDescontarSaldoReservadoCD', 'Se desconta o saldo reservado do saldo disponível do CD (S/N)', ftString);
  pAdicionaParametroRotina(tprAlteraOrcamentoPedido, 'strDescontarSaldoReservadoDestino', 'Se desconta o saldo reservado do saldo disponível da origem (S/N)', ftString);
  pAdicionaParametroRotina(tprAlteraOrcamentoPedido, 'strEntregaFuturaFaltaProduto', 'Se considera entrega futura por "Falta de Produto" (S/N)', ftString);
  pAdicionaParametroRotina(tprAlteraOrcamentoPedido, 'strEntregaFuturaPrevisaoEntrega', 'Se considera entrega futura por "Previsão de Entrega" (S/N)', ftString);
  pAdicionaParametroRotina(tprAlteraOrcamentoPedido, 'strEntregaFuturaAguardaCliente', 'Se considera entrega futura por "Aguarda Cliente" (S/N)', ftString);
End;

Function TRotinasGrid.fAlteraOrcamento: Boolean;
Begin
{  TRelGeraOR.pAlteraOrcamentoPedido(fGetValorParametro('strEmpresaCD', ftString),
                                    fGetValorParametro('strDescontarSaldoReservadoCD', ftString) = 'S',
                                    fGetValorParametro('strEmpresaDestino', ftString),
                                    fGetValorParametro('strDescontarSaldoReservadoDestino', ftString) = 'S',
                                    CONCAT(IIF(fGetValorParametro('strEntregaFuturaFaltaProduto', ftString) = 'S', 'F', ''),
                                       IIF(fGetValorParametro('strEntregaFuturaPrevisaoEntrega', ftString) = 'S', 'P', ''),
                                       IIF(fGetValorParametro('strEntregaFuturaAguardaCliente', ftString) = 'S', 'A', '')));   }
  Result := True;
End;

Procedure TRotinasGrid.pAdicionaRotinaGeraPedidoOrcamentoTE;
Begin
  If Not fAdicionaRotina(tprGeraPedidoOrcamentoTE, 'Geração de Orçamento/Pedido para T.E.', '', UsaClientRelatorio) Then
    Exit;

  pAdicionaParametroRotina(tprGeraPedidoOrcamentoTE, 'strEmpresaCD', 'Código da empresa CD (não pode ser multiseleção)', ftString);
  pAdicionaParametroRotina(tprGeraPedidoOrcamentoTE, 'strEmpresaDestino', 'Empresa destino', ftString);
  pAdicionaParametroRotina(tprGeraPedidoOrcamentoTE, 'strQuebraPorUnidade', 'Se quebra o pedido por grupo de unidade (S/N)', ftString);
  pAdicionaParametroRotina(tprGeraPedidoOrcamentoTE, 'intItensPorPedido', 'Quantidade de itens por pedido', ftInteger);

  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'MARDES', 'Marcado (M) / Desmarcado (D)',  ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'CODEMP', 'Código da empresa destino', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'CODITE', 'Código do item', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'DESITE', 'Desscrição do item', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'UNIDAD', 'Código da unidade do item',  ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'SIGUNI', 'Sigla da unidade do item',  ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'UNIGRU', 'Descrição do grupo da unidade',  ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'TEMLOT', 'Se o item tem lote ou não (S/N)', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'NUMLOT', 'Número do lote', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'CODMAR', 'Código da marca do item', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'REFERE', 'Referência do item', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'CODFOR', 'Fornecedor do item', ftString);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'INCPIS', 'Indide PIS (S/N)', ftString);

  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'UNITAR', 'Preço unitário do item', ftFloat);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'PRECUS', 'Preço de custo do item', ftFloat);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'PREMED', 'Preço médio do item', ftFloat);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'PESOIT', 'Peso unitário do item', ftFloat);
  pAdicionaCampoRotina(tprGeraPedidoOrcamentoTE, 'NECCOM', 'Necessidade de compra', ftFloat);
End;

function TRotinasGrid.fTransferePedido: Boolean;
Begin
{  Result := TRelGeraOR.fGeraPedidosConsulta(TUniClientDataSet(fGetClientRelatorio),
                                            fGetValorParametro('strEmpresaCD', ftString),
                                            fGetValorParametro('strEmpresaDestino', ftString, False),
                                            fGetValorParametro('strQuebraPorUnidade', ftString) = 'S',
                                            fGetValorParametro('intItensPorPedido', ftInteger));  }
  Result := False;
End;

Procedure TRotinasGrid.pAdicionaRotinaAbrirFormulario;
Begin
  If Not fAdicionaRotina(tprAbrirFormulario, 'Abrindo Formulário', '', Not UsaClientRelatorio) Then
    Exit;

  pAdicionaParametroRotina(tprAbrirFormulario, 'strNomeFormulario', 'Nome do Formulário a ser aberto', ftString);
End;

function TRotinasGrid.fAbrirFormulario: Boolean;
var
  strNomFrm: String;
Begin
  strNomFrm := fGetValorParametro('strNomeFormulario', ftString);
  Result := fAbrirFormularioNome(strNomFrm);
End;

function TRotinasGrid.fAbrirFormularioNome(const strNomFrm: String): Boolean;
var
  ctx: TRttiContext;
  typ: TRttiType;
  frmClass: TComponentClass;
  frmForm: TForm;
begin
  frmForm := nil;
  frmClass := nil;

  for typ in ctx.GetTypes do
  begin
    if (typ is TRttiInstanceType) and (TRttiInstanceType(typ).MetaclassType.InheritsFrom(TForm)) then
    begin
      if typ.Name = strNomFrm then
      begin
        frmClass := TComponentClass(TRttiInstanceType(typ).MetaclassType);
        Break;
      end;
    end;
  end;

  if Assigned(FrmClass) then
  begin
    pCriarFormularios(frmClass, frmForm);

    try
      frmForm.ShowModal;
    finally
      pFreeAndNil(frmForm);
    end;

    Result := True;
  end
  else
  begin
    pMensagensErro('Formulário ' + strNomFrm + ' não encontrado.', '[TRotinasGrid.fAbrirFormularioNome]');
    Result := True;
  end;

end;

function TRotinasGrid.fExecutaRotina: Boolean;
Begin
  Result := True;

  Try
    Case FRotinaCorrente Of
      tprGeraPedidoOrcamentoTE: Result := fTransferePedido;
      tprAbrirFormulario      : Result := fAbrirFormulario;
      tprAlteraOrcamentoPedido: Result := fAlteraOrcamento;
    End;

  Except
    On E: ExceptionAutcom Do
    Begin
      Result := False;
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TRotinasGrid.fExecutaRotina]');
    End;
  End;
End;

end.
