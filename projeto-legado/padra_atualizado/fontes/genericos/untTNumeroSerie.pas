
unit untTNumeroSerie;

interface

uses untZClient, Classes, SysUtils, Uni, System.Generics.Collections, Data.DB, untFuncoesSimples;

  Type
    TTipoProcesso = (tpEntrada, tpSaida, tpCadProduto);
    TTipoRotina = (tpEnderecamento, tpEntradaSimplificada);

    ExceptionNumeroSerie = Class(Exception)
      Local: string;
      constructor create(AMessage: String; ALocal: String);
    End;


    TNumeroSerie = Class
    private
      qrySeries: TZClient;
      FCodProduto: String;
      FCodEmpresa: String;
      FAutoincrem: string;
      FAutoIncremMovDetTE: String;
      FAutoIncremFatDor: String;
      FTipoProcesso: TTipoProcesso;
      FqryGen,
      FQryConsulta,
      FQryDelete: TUniQuery;
      FTipoRotina: TTipoRotina;
      //Alimentada pelo cancelamento
      FstrEspSel: String;
      FBlnDevolucao: Boolean;
      function fGetSQL: string;
      function fGetSQLCadProdutos: string;
      function fGetSQLMovimento: String;
      function fAtualizaTabela_MovimentoSerie: Boolean;
      function fAtualizaTabela_ProdutosSerie: Boolean;
      function fInsertProdutoSerie: Boolean;
      function fInsertMovimentoSerie: Boolean;
      function fMontaSQLReplace_PROSER(strAUTOINCREM, strSER_CODITE, strSER_NUMSER, strSER_CODEMP: string): String; overload;
      function fMontaSQLReplace_PROSER(strAUTOINCREM, strSER_CODITE, strSER_NUMSER, strSER_CODEMP, strSER_AJUSTE: string): String; overload;
      procedure pAbreCDS;
      procedure pCancelaEntrada();
      procedure pCancelaSaida;
      procedure pCancelaViaDevolucao(AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao);
      procedure pCancelaViaDevolucaoConfirmacaoDocumento(AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao);
      procedure pAjustaEstoqueEntrada(AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao);
      procedure pAjustaEstoqueSaida(ANumSer, ACodIte, AEmpIte, ASeqGer: String);
      procedure pCancelaSaidaAjuste(ANumSer, ACodEmp, ACodIte, AAutIncDetSer: String);
      procedure pCancelaEntradaAjuste(AAutInc: String);
    protected
      procedure pCancelamento(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc, strEspSel: string);
      procedure pCancelaConfirmacaoDocumento(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc: String);
      procedure pCancelamentoAjusteEstoque(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp: String);
    public
     // Guarda todos os numeros de serie utlizados para ser mais facil proucuralos de fora da classe
      SeriesUtlizadas: TStringList;
      Constructor Create;
      //para ver os numeros de serie do produto. //SERPRO
      procedure pInicia(ACodProduto, ACodEmpresa: string; AStrAutIncMovDetTE: String = ''; AStrAutIncFatDor: String = ''; ABlnDevolucao: Boolean = False); overload;
      //Ver os Numeros de Serie de apartir das movdets
      procedure pInicia(AAutoIncrem: String; ATipoProcesso: TTipoProcesso; AStrAutIncMovDetTE: String = ''; AStrAutIncFatDor: String = ''; ABlnDevolucao: Boolean = False); overload;
      Destructor Destroy;override;
      //Chama a tela que exibe os numeros de serie
      procedure pVisualizaNumerosDeSerie;
      //Quando For movimento de entrada ou de saida mentodo para salvar as alterações
      function fSalva: Boolean;
      //Autoincrem Setado no pInicia
      property Autoincrem: string Read FAutoincrem;
      //Controle de qual rotina está usando, endereçamento ou entrada simplificada
      property TipoRotina: TTipoRotina Read FTipoRotina Write FTipoRotina;
      //Controla se é um endereçamento oriunde de devolução
      property blnDevolucao: Boolean Read FBlnDevolucao Write FBlnDevolucao;
      //Quando for movimento de entrada ou saida saber se todos os itens foram devidamente indentificados
      function fTodosItensDefinidos: Boolean;
      // chamado apartir do cancelamento para poder desfazer as relações com as tabelas PROSER e DETSER
      class function Cancelamento(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc, strEspSel: string): Boolean;
      // chamado apartir do cancelamento para poder desfazer as relações dos números de série de uma confirmação de documento
      class function CancelamentoConfirmacaoDocumento(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc: string): Boolean;
      //Quando já tem ENTSER definida pela saída ( Emissão da T.E na EMP origem)
      function fExisteEntSer: Boolean;
      //Chama na devolução de documento para poder cancelar de forma parcial
      class function fCancelaViaDevolucao(AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao): Boolean;
      //Chama na devolução de confirmação de documento para poder cancelar de forma parcial
      class function fCancelaViaDevolucaoConfirmacaoDocumento(AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao): Boolean;
      //Chama no ajuste de estoque para entrada de produtos
      class function fAjustaEstoqueEntrada(AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao): Boolean;
      //Chama no ajuste de estoque para saída de produtos
      class function fAjustaEstoqueSaida(ANumSer, ACodIte, AEmpIte, ASeqGer: String): Boolean;
      // chamado apartir do cancelamento para cancelar o documento de ajuste de estoque
      class function fCancelamentoAjusteEstoque(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp: String): Boolean;
   End;

   TListaSeries = Class
   private
     FListSeries: TList<TNumeroSerie>;
     procedure pLimpaLista;
     function GetNumeroSerie(AAutoincremIndex: String): TNumeroSerie;
   public
     constructor Create;
     //Cria um Objeto TNumeroSerie para a movdet indicada no Autoincrem
     procedure pAdd(AAutoincrem: String; ATipoProcesso: TTipoProcesso; AStrAutIncMovDetTE: String = ''; AStrAutIncFatDor: String = ''; ABlnDevolucao: Boolean = False);
     procedure LimparLista;
     ///percorrer todos os objetos TNumeroSerie para saber se o numero de serie ja foi utilizado
     function fExiste(strNumSer, strCodIte: string; blnGeral: Boolean = False): boolean;
     destructor Destroy; override;
     //Carrega da Lista de acordo com o autoincrem da movdet
     property NumeroSerie[AAutoincremIndex: String]: TNumeroSerie read GetNumeroSerie;


   End;

implementation

uses
  untNumeroSerie, Vcl.Controls;

{ TNumeroSerie }

class function TNumeroSerie.Cancelamento(AstrCliFor, AstrNumDoc, AstrEspDoc,
  AstrCodEmp, strSerie, strTipFc, strEspSel: string): Boolean;
Var objNumerosSeries: TNumeroSerie;
begin
  Result := True;
  objNumerosSeries := TNumeroSerie.Create;
  Try
    Try
      objNumerosSeries.pCancelamento(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc, strEspSel);
    Except
       On E: Exception do
       Begin

         pMensagensErro(E.message, 'TNumeroSerie.Cancelamento');
         pMensagemOk(e.Message);
         Result := False;
       End;
    End;
  Finally
    FreeAndNil(objNumerosSeries);
  End;
end;

procedure TNumeroSerie.pCancelamento(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc, strEspSel: string);
begin
  FqryGen.SQL.Clear;
  strEspSel := strEspSel;
  FCodEmpresa := AstrCodEmp;
  FqryGen.SQL.Add('SELECT DET_CODITE, DET_CODEMP, DET_CLAFIS, DET_QTDITE, AUTOINCREM FROM MOVDET ');
  FqryGen.SQL.Add(' WHERE DET_CODEMP = ' + QuotedStr(AstrCodEmp));
  FqryGen.SQL.Add('   AND DET_NUMDOC = ' + QuotedStr(AstrNumDoc));
  FqryGen.SQL.Add('   AND DET_ESPDOC = ' + QuotedStr(AstrEspDoc));
  If Not fEmptyStr(strSerie) Then
    FqryGen.SQL.Add('    AND IFNULL(DET_SERIE_, "") = ' + QuotedStr(strSerie));
  If strTipFc = 'CODFOR' Then
    FqryGen.SQL.Add('    AND DET_CODFOR = ' + QuotedStr(AstrCliFor) + '; ')
  Else
    FqryGen.SQL.Add('    AND DET_CODCLI = ' + QuotedStr(AstrCliFor) + '; ');

  FqryGen.Open;

  If FqryGen.IsEmpty Then
    Exit;
  FqryGen.First;
  While Not FqryGen.Eof Do
  Begin
    If FqryGen.FieldByName('DET_CLAFIS').AsString = '' Then
       raise Exception.Create('A Classificação da Tabela MOVDET esta vazia!');
    If FqryGen.FieldByName('DET_CLAFIS').AsInteger < 5000 Then
      pCancelaEntrada
    Else
      pCancelaSaida;
    FqryGen.Next;
  End;
end;

procedure TNumeroSerie.pCancelamentoAjusteEstoque(AstrCliFor, AstrNumDoc,
  AstrEspDoc, AstrCodEmp: String);
var
  LProdutos: TUniQuery;
  LNumSer: TUniQuery;
begin
  LProdutos := fCriaQuery;
  LNumSer := fCriaQuery;

  try
    LProdutos.Close;
    LProdutos.SQL.Clear;
    LProdutos.SQL.Add('SELECT AUTOINCREM, DET_CODITE, DET_CLAFIS');
    LProdutos.SQL.Add('FROM MOVDET');
    LProdutos.SQL.Add('WHERE DET_NUMDOC= :NUMDOC');
    LProdutos.SQL.Add('AND DET_ESPDOC = :ESPDOC');
    LProdutos.SQL.Add('AND DET_CODEMP = :CODEMP');
    LProdutos.SQL.Add('AND DET_CODCLI = :CODCLI');

    LProdutos.ParamByName('NUMDOC').AsString := AstrNumDoc;
    LProdutos.ParamByName('ESPDOC').AsString := AstrEspDoc;
    LProdutos.ParamByName('CODEMP').AsString := AstrCodEmp;
    LProdutos.ParamByName('CODCLI').AsString := AstrCliFor;

    LProdutos.Open;

    if LProdutos.IsEmpty then
      Exit;

    LNumSer.Close;
    LNumSer.SQL.Clear;
    LNumSer.SQL.Add('SELECT SER_NUMSER FROM DETSER WHERE SER_SEQGER = :SEQGER');

    while not LProdutos.Eof do
    begin
      if LProdutos.FieldByName('DET_CLAFIS').AsInteger < 5000 then
      begin
        pCancelaEntradaAjuste(LProdutos.FieldByName('AUTOINCREM').AsString);
      end
      else
      begin
        LNumSer.Close;
        LNumSer.ParamByName('SEQGER').AsString := LProdutos.FieldByName('AUTOINCREM').AsString;
        LNumSer.Open;

        while not LNumSer.Eof do
        begin
          pCancelaSaidaAjuste(LNumSer.FieldByName('SER_NUMSER').AsString, AstrCodEmp, LProdutos.FieldByName('DET_CODITE').AsString, LProdutos.FieldByName('AUTOINCREM').AsString);
          LNumSer.Next;
        end;
      end;

      LProdutos.Next;
    end;
  finally
    FreeAndNil(LProdutos);
    FreeAndNil(LNumSer);
  end;
end;

procedure TNumeroSerie.pCancelaConfirmacaoDocumento(AstrCliFor, AstrNumDoc,
  AstrEspDoc, AstrCodEmp, strSerie, strTipFc: String);
Var
  LAutIncNotDet: String;
begin
  FqryGen.Close;
  FqryGen.SQL.Clear;

  FqryGen.SQL.Add('SELECT AUTOINCREM');
  FqryGen.SQL.Add('FROM NOTDET');
  FqryGen.SQL.Add('WHERE DET_NUMDOC = :NUMDOC');
  FqryGen.SQL.Add('AND DET_ESPDOC = :ESPDOC');
  FqryGen.SQL.Add('AND DET_CODEMP = :CODEMP');

  If strTipFc = 'CODFOR' Then
    FqryGen.SQL.Add('AND DET_CODFOR = :CLIFOR')
  Else
    FqryGen.SQL.Add('AND DET_CODCLI = :CLIFOR');

  FqryGen.ParamByName('NUMDOC').AsString := AstrNumDoc;
  FqryGen.ParamByName('ESPDOC').AsString := AstrEspDoc;
  FqryGen.ParamByName('CODEMP').AsString := AstrCodEmp;
  FqryGen.ParamByName('CLIFOR').AsString := AstrCliFor;

  If Not fEmptyStr(strSerie) Then
  Begin
    FqryGen.SQL.Add('AND IFNULL(DET_SERIE_, "") = :SERIE');
    FqryGen.ParamByName('SERIE').AsString := strSerie;
  End;

  FqryGen.Open;

  If FqryGen.IsEmpty Then
    Exit;

  LAutIncNotDet := EmptyStr;

  While Not FqryGen.Eof Do
  Begin
    pIncrementaListaStr(FqryGen.FieldByName('AUTOINCREM').AsString, LAutIncNotDet, True);

    FqryGen.Next;
  End;

  If fEmptyStr(LAutIncNotDet) Then
    Exit;

  FqryGen.Close;
  FqryGen.SQL.Clear;

  FqryGen.SQL.Add('UPDATE DETSER');
  FqryGen.SQL.Add('SET SER_SEQNOT = NULL');
  FqryGen.SQL.Add('WHERE SER_SEQNOT IN('+LAutIncNotDet+')');

  FqryGen.ExecSQL;
end;

procedure TNumeroSerie.pCancelaEntrada();
var strSQLDelete: String;
Begin
  FQryConsulta.SQL.Text := 'SELECT * FROM DETSER WHERE SER_SEQGER = ' + QuotedStr(FqryGen.FieldByName('AUTOINCREM').AsString);
  FQryConsulta.Open;
  If FQryConsulta.IsEmpty Then
    Exit;
  strSQLDelete := '';
  While Not FQryConsulta.Eof Do
  Begin
    fVerificaIntegridade('TNumeroSerie.pCancelaEntrada', 'DETSER', FQryConsulta, True, False, '', '', False, FstrEspSel);
    strSQLDelete := strSQLDelete + 'DELETE FROM PROSER ';
    strSQLDelete := strSQLDelete + ' WHERE SER_CODEMP = ' + QuotedStr(FQryGen.FieldByName('DET_CODEMP').AsString);
    strSQLDelete := strSQLDelete + '   AND SER_CODITE = ' + QuotedStr(FQryGen.FieldByName('DET_CODITE').AsString);
    strSQLDelete := strSQLDelete + '   AND SER_NUMSER = ' + QuotedStr(FQryConsulta.FieldByName('SER_NUMSER').AsString) +';';
    FQryConsulta.Next;
  End;

  FQryDelete.SQL.Text := strSQLDelete;
  FQryDelete.ExecSQL;



  FQryDelete.SQL.Text := 'DELETE FROM DETSER WHERE SER_SEQGER = ' + QuotedStr(FqryGen.FieldByName('AUTOINCREM').AsString);
  FQryDelete.ExecSQL;
End;

procedure TNumeroSerie.pCancelaEntradaAjuste(AAutInc: String);
var
  LEntradaAjuste: TUniQuery;
begin
  LEntradaAjuste := fCriaQuery;

  try
    LEntradaAjuste.Close;
    LEntradaAjuste.SQL.Clear;
    LEntradaAjuste.SQL.Add('DELETE FROM PROSER WHERE SER_AJUSTE = :AJUSTE');
    LEntradaAjuste.ParamByName('AJUSTE').AsString := AAutInc;
    LEntradaAjuste.ExecSQL;
  finally
    FreeAndNil(LEntradaAjuste);
  end;
end;

procedure TNumeroSerie.pCancelaSaida;
var strSQLDelete, strAutInc: string;
Begin
  FQryConsulta.SQL.Text := 'SELECT * FROM DETSER WHERE SER_SEQGER = ' + QuotedStr(FqryGen.FieldByName('AUTOINCREM').AsString);
  FQryConsulta.Open;
  If FQryConsulta.IsEmpty Then
    Exit;
  strSQLDelete := '';
  strAutInc := fRetAutoIncrem('PROSER', FCodEmpresa, FQryConsulta.RecordCount);
  While Not FQryConsulta.Eof Do
  Begin
    strSQLDelete := strSQLDelete + fMontaSQLReplace_PROSER(strAutInc,
                                                           FqryGen.FieldByName('DET_CODITE').AsString,
                                                           FQryConsulta.FieldByName('SER_NUMSER').AsString,
                                                           FqryGen.FieldByName('DET_CODEMP').AsString);

    FQryConsulta.Next;
    pIncrementaAutoIncrem(strAutInc);
    fVerificaIntegridade('TNumeroSerie.pCancelaEntrada', 'DETSER', FQryConsulta, True, False, '', '', False, FstrEspSel);
  End;

  FQryDelete.SQL.Text := strSQLDelete;
  FQryDelete.ExecSQL;


  FQryDelete.SQL.Text := 'DELETE FROM DETSER WHERE SER_SEQGER = ' + QuotedStr(FqryGen.FieldByName('AUTOINCREM').AsString);
  FQryDelete.ExecSQL;
End;

procedure TNumeroSerie.pCancelaSaidaAjuste(ANumSer, ACodEmp, ACodIte,
  AAutIncDetSer: String);
var
  LSaidaAjuste: TUniQuery;
  LAutIncProSer: String;
begin
  LSaidaAjuste := fCriaQuery;

  try
    LAutIncProSer := fRetAutoIncrem('PROSER', ACodEmp);

    LSaidaAjuste.Close;
    LSaidaAjuste.SQL.Clear;
    LSaidaAjuste.SQL.Add('INSERT INTO PROSER(AUTOINCREM, SER_CODITE, SER_NUMSER, SER_CODEMP)');
    LSaidaAjuste.SQL.Add('VALUES(:AUTINC, :CODITE, :NUMSER, :CODEMP)');
    LSaidaAjuste.ParamByName('AUTINC').AsString := LAutIncProSer;
    LSaidaAjuste.ParamByName('CODITE').AsString := ACodIte;
    LSaidaAjuste.ParamByName('NUMSER').AsString := ANumSer;
    LSaidaAjuste.ParamByName('CODEMP').AsString := ACodEmp;
    LSaidaAjuste.ExecSQL;

    LSaidaAjuste.Close;
    LSaidaAjuste.SQL.Clear;
    LSaidaAjuste.SQL.Add('DELETE FROM DETSER');
    LSaidaAjuste.SQL.Add('WHERE SER_SEQGER = :SEQGER');
    LSaidaAjuste.SQL.Add('AND SER_NUMSER = :NUMSER');
    LSaidaAjuste.ParamByName('SEQGER').AsString := AAutIncDetSer;
    LSaidaAjuste.ParamByName('NUMSER').AsString := ANumSer;
    LSaidaAjuste.ExecSQL;

  finally
    FreeAndNil(LSaidaAjuste);
  end;
end;

procedure TNumeroSerie.pCancelaViaDevolucao(
  AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao);
var
  LqryRetornaNumeroSerie: TUniQuery;
  LItensNumeroSerieDevolucao: TrecItensNumeroSerieDevolucao;
  LstrAutInc: String;
  LstrSQL: String;
  LstrAutIncSer: String;
begin
  LqryRetornaNumeroSerie := fCriaQuery;

  try
    LstrSQL := EmptyStr;
    LstrAutIncSer := EmptyStr;

    for LItensNumeroSerieDevolucao in AarrItensNumeroSerieDevolucao do
    begin
      if LItensNumeroSerieDevolucao.strTabDev = 'NOTDET' then
        Continue;

      LstrAutInc := fRetAutoIncrem('PROSER', LItensNumeroSerieDevolucao.strEmpDoc);

      LstrSQL := LstrSQL + fMontaSQLReplace_PROSER(LstrAutInc,
                                                   LItensNumeroSerieDevolucao.strCodIte,
                                                   LItensNumeroSerieDevolucao.strNumeroSerie,
                                                   LItensNumeroSerieDevolucao.strEmpIte);

      pIncrementaListaStr(LItensNumeroSerieDevolucao.strAutIncSer, LstrAutIncSer, True);
    end;

    if fEmptyStr(LstrSQL) then
      Exit;

    LqryRetornaNumeroSerie.Close;
    LqryRetornaNumeroSerie.SQL.Clear;
    LqryRetornaNumeroSerie.SQL.Add(LstrSQL);
    LqryRetornaNumeroSerie.ExecSQL;

    LqryRetornaNumeroSerie.Close;
    LqryRetornaNumeroSerie.SQL.Clear;
    LqryRetornaNumeroSerie.SQL.Add('DELETE FROM DETSER WHERE AUTOINCREM IN('+LstrAutIncSer+')');
    LqryRetornaNumeroSerie.ExecSQL;
  finally
    FreeAndNil(LqryRetornaNumeroSerie);
  end;
end;

class function TNumeroSerie.CancelamentoConfirmacaoDocumento(AstrCliFor,
  AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc: string): Boolean;
Var
  objNumerosSeries: TNumeroSerie;
begin
  Result := True;
  objNumerosSeries := TNumeroSerie.Create;
  Try
    Try
      objNumerosSeries.pCancelaConfirmacaoDocumento(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp, strSerie, strTipFc);
    Except
       On E: Exception do
       Begin

         pMensagensErro(E.message, 'TNumeroSerie.pCancelaConfirmacaoDocumento');
         pMensagemOk(e.Message);
         Result := False;
       End;
    End;
  Finally
    FreeAndNil(objNumerosSeries);
  End;
end;

procedure TNumeroSerie.pCancelaViaDevolucaoConfirmacaoDocumento(
  AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao);
var
  LqryDevolucao: TUniQuery;
  LAutIncDevolver: String;
  LItensNumeroSerieDevolucao: TrecItensNumeroSerieDevolucao;
  LstrAutInc: String;
  LstrSQL: String;
begin
  LAutIncDevolver := EmptyStr;
  LstrSQL := EmptyStr;

  for LItensNumeroSerieDevolucao in AarrItensNumeroSerieDevolucao do
  begin
    if LItensNumeroSerieDevolucao.strTabDev <> 'NOTDET' then
      Continue;

    LstrAutInc := fRetAutoIncrem('PROSER', LItensNumeroSerieDevolucao.strEmpDoc);

    LstrSQL := LstrSQL + fMontaSQLReplace_PROSER(LstrAutInc,
                                                 LItensNumeroSerieDevolucao.strCodIte,
                                                 LItensNumeroSerieDevolucao.strNumeroSerie,
                                                 LItensNumeroSerieDevolucao.strEmpIte);

    pIncrementaListaStr(LItensNumeroSerieDevolucao.strAutIncSer, LAutIncDevolver, True);
  end;

  if fEmptyStr(LstrSQL) then
    Exit;

  LqryDevolucao := fCriaQuery;

  try
    LqryDevolucao.Close;
    LqryDevolucao.SQL.Clear;
    LqryDevolucao.SQL.Add(LstrSQL);
    LqryDevolucao.ExecSQL;

    LqryDevolucao.Close;
    LqryDevolucao.SQL.Clear;
    LqryDevolucao.SQL.Add('DELETE FROM DETSER WHERE AUTOINCREM IN('+LAutIncDevolver+')');
    LqryDevolucao.ExecSQL;
  finally
    FreeAndNil(LqryDevolucao);
  end;
end;

constructor TNumeroSerie.Create;
begin
  If Not Assigned(frmNumeroSerie) Then
    pCriarFormularios(TfrmNumeroSerie, frmNumeroSerie);
  SeriesUtlizadas := TStringList.Create;
  FTipoProcesso := tpCadProduto;
  FqryGen := fCriaQuery;
  FQryConsulta := fCriaQuery;
  FQryDelete := fCriaQuery;
  FCodEmpresa := VS_strCodEmp;
  qrySeries := TZClient.Create(nil, fGetSQL);

end;

procedure TNumeroSerie.pInicia(ACodProduto, ACodEmpresa: string; AStrAutIncMovDetTE: String = ''; AStrAutIncFatDor: String = ''; ABlnDevolucao: Boolean = False);
Begin
  FTipoProcesso := tpCadProduto;
  FCodProduto := ACodproduto;
  FCodEmpresa := ACodEmpresa;
  FAutoincrem := '';
  FAutoIncremMovDetTE := AStrAutIncMovDetTE;
  FAutoIncremFatDor := AStrAutIncFatDor;
  FBlnDevolucao := ABlnDevolucao;
  pAbreCDS;
End;

procedure TNumeroSerie.pInicia(AAutoIncrem: String; ATipoProcesso: TTipoProcesso; AStrAutIncMovDetTE: String = ''; AStrAutIncFatDor: String = ''; ABlnDevolucao: Boolean = False);
Begin
  FTipoProcesso := ATipoProcesso;
  FAutoincrem := AAutoincrem;
  FCodProduto := '';
  FCodEmpresa := VS_StrCodEmp;
  FAutoIncremMovDetTE := AStrAutIncMovDetTE;
  FAutoIncremFatDor := AStrAutIncFatDor;
  If Not fEmptyStr(FAutoIncremFatDor) Then
    FTipoRotina := tpEnderecamento;
  FBlnDevolucao := ABlnDevolucao;
  pAbreCDS;
End;

procedure TNumeroSerie.pAbreCDS;
begin
  If Assigned(qrySeries) Then
    FreeAndNil(qrySeries);
  qrySeries := TZClient.Create(nil, fGetSQL);
  qrySeries.fAbreClient(False, 'TNumeroSerie.Create');
end;


procedure TNumeroSerie.pAjustaEstoqueEntrada(
  AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao);
var
  LqryRetornaNumeroSerie: TUniQuery;
  LItensNumeroSerieDevolucao: TrecItensNumeroSerieDevolucao;
  LstrAutInc: String;
  LstrSQL: String;
begin
  LqryRetornaNumeroSerie := fCriaQuery;

  try
    LstrSQL := EmptyStr;

    for LItensNumeroSerieDevolucao in AarrItensNumeroSerieDevolucao do
    begin
      LstrAutInc := fRetAutoIncrem('PROSER', LItensNumeroSerieDevolucao.strEmpDoc);

      LstrSQL := LstrSQL + fMontaSQLReplace_PROSER(LstrAutInc,
                                                   LItensNumeroSerieDevolucao.strCodIte,
                                                   LItensNumeroSerieDevolucao.strNumeroSerie,
                                                   LItensNumeroSerieDevolucao.strEmpIte,
                                                   LItensNumeroSerieDevolucao.strAutIncDet);

    end;

    if fEmptyStr(LstrSQL) then
      Exit;

    LqryRetornaNumeroSerie.Close;
    LqryRetornaNumeroSerie.SQL.Clear;
    LqryRetornaNumeroSerie.SQL.Add(LstrSQL);
    LqryRetornaNumeroSerie.ExecSQL;
  finally
    FreeAndNil(LqryRetornaNumeroSerie);
  end;
end;

procedure TNumeroSerie.pAjustaEstoqueSaida(ANumSer, ACodIte, AEmpIte,
  ASeqGer: String);
var
  FAjustaSaida: TUniQuery;
  FAutIncDetSer: String;
begin
  FAjustaSaida := fCriaQuery;

  try
    FAutIncDetSer := fRetAutoIncrem('DETSER', AEmpIte);

    FAjustaSaida.Close;
    FAjustaSaida.SQL.Clear;
    FAjustaSaida.SQL.Add('INSERT INTO DETSER(AUTOINCREM, SER_SEQGER, SER_NUMSER)');
    FAjustaSaida.SQL.Add('VALUES(:AUTINC, :SEQGER, :NUMSER)');
    FAjustaSaida.ParamByName('AUTINC').AsString := FAutIncDetSer;
    FAjustaSaida.ParamByName('SEQGER').AsString := ASeqGer;
    FAjustaSaida.ParamByName('NUMSER').AsString := ANumSer;
    FAjustaSaida.ExecSQL;

    FAjustaSaida.Close;
    FAjustaSaida.SQL.Clear;
    FAjustaSaida.SQL.Add('DELETE FROM PROSER');
    FAjustaSaida.SQL.Add('WHERE SER_CODITE = :CODITE');
    FAjustaSaida.SQL.Add('AND SER_NUMSER = :NUMSER');
    FAjustaSaida.SQL.Add('AND SER_CODEMP = :CODEMP');
    FAjustaSaida.ParamByName('CODITE').AsString := ACodIte;
    FAjustaSaida.ParamByName('NUMSER').AsString := ANumSer;
    FAjustaSaida.ParamByName('CODEMP').AsString := AEmpIte;
    FAjustaSaida.ExecSQL;
  finally
    FreeAndNil(FAjustaSaida);
  end;
end;

class function TNumeroSerie.fAjustaEstoqueEntrada(
  AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao): Boolean;
var
  objNumerosSeries: TNumeroSerie;
begin
  Result := True;
  objNumerosSeries := TNumeroSerie.Create;
  Try
    Try
      objNumerosSeries.pAjustaEstoqueEntrada(AarrItensNumeroSerieDevolucao);
    Except
       On E: Exception do
       Begin
         pMensagensErro(E.message, 'TNumeroSerie.fAjustaEstoqueEntrada');
         Result := False;
       End;
    End;
  Finally
    FreeAndNil(objNumerosSeries);
  End;
end;

class function TNumeroSerie.fAjustaEstoqueSaida(ANumSer, ACodIte, AEmpIte, ASeqGer: String): Boolean;
var
  objNumerosSeries: TNumeroSerie;
begin
  Result := True;
  objNumerosSeries := TNumeroSerie.Create;
  Try
    Try
      objNumerosSeries.pAjustaEstoqueSaida(ANumSer, ACodIte, AEmpIte, ASeqGer);
    Except
       On E: Exception do
       Begin
         pMensagensErro(E.message, 'TNumeroSerie.fAjustaEstoqueSaida');
         Result := False;
       End;
    End;
  Finally
    FreeAndNil(objNumerosSeries);
  End;
end;

function TNumeroSerie.fAtualizaTabela_MovimentoSerie: Boolean;
begin
  Result := False;
  If (FTipoProcesso = tpEntrada) Then
    Result := fInsertMovimentoSerie
end;

function TNumeroSerie.fAtualizaTabela_ProdutosSerie: Boolean;
begin
  Result := fInsertProdutoSerie;
end;

class function TNumeroSerie.fCancelamentoAjusteEstoque(AstrCliFor, AstrNumDoc,
  AstrEspDoc, AstrCodEmp: String): Boolean;
Var
  objNumerosSeries: TNumeroSerie;
begin
  Result := True;
  objNumerosSeries := TNumeroSerie.Create;
  Try
    Try
      objNumerosSeries.pCancelamentoAjusteEstoque(AstrCliFor, AstrNumDoc, AstrEspDoc, AstrCodEmp);
    Except
       On E: Exception do
       Begin
         pMensagensErro(E.message, 'TNumeroSerie.pCancelamentoAjusteEstoque');
         pMensagemOk(e.Message);
         Result := False;
       End;
    End;
  Finally
    FreeAndNil(objNumerosSeries);
  End;
end;

class function TNumeroSerie.fCancelaViaDevolucao(
  AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao): Boolean;
var
  objNumerosSeries: TNumeroSerie;
begin
  Result := True;
  objNumerosSeries := TNumeroSerie.Create;
  Try
    Try
      objNumerosSeries.pCancelaViaDevolucao(AarrItensNumeroSerieDevolucao);
    Except
       On E: Exception do
       Begin
         pMensagensErro(E.message, 'TNumeroSerie.fCancelaViaDevolucao');
         Result := False;
       End;
    End;
  Finally
    FreeAndNil(objNumerosSeries);
  End;
end;

class function TNumeroSerie.fCancelaViaDevolucaoConfirmacaoDocumento(
  AarrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao): Boolean;
var
  objNumerosSeries: TNumeroSerie;
begin
  Result := True;
  objNumerosSeries := TNumeroSerie.Create;
  Try
    Try
      objNumerosSeries.pCancelaViaDevolucaoConfirmacaoDocumento(AarrItensNumeroSerieDevolucao);
    Except
       On E: Exception do
       Begin
         pMensagensErro(E.message, 'TNumeroSerie.fCancelaViaDevolucaoConfirmacaoDocumento');
         Result := False;
       End;
    End;
  Finally
    FreeAndNil(objNumerosSeries);
  End;
end;

function TNumeroSerie.fInsertMovimentoSerie: Boolean;
var strAutInc: string;
begin
  Try
    Result := True;
    qrySeries.First;
    strAutInc := fRetAutoIncrem('DETSER', FCodEmpresa, qrySeries.RecordCount);
    FqryGen.SQL.Clear;
    While Not qrySeries.Eof Do
    Begin
      FqryGen.SQL.Add('INSERT INTO DETSER (AUTOINCREM, SER_SEQGER, SER_NUMSER) VALUES (');
      FqryGen.SQL.Add(QuotedStr(strAutInc) + ',');
      FqryGen.SQL.Add(QuotedStr(FAutoincrem) + ',');
      FqryGen.SQL.Add(QuotedStr(qrySeries.FieldByName('SER_NUMSER').AsString) + ');');
      qrySeries.Next;
      pIncrementaAutoIncrem(strAutInc);
    End;
    If Not fEmptyStr(FqryGen.SQL.Text) Then
      FqryGen.ExecSQL;
  Except
    On E: Exception do
    Begin
      pMensagensErro(E.message, 'TNumeroSerie.fInsertMovimentoSerie');
      Result := False;
    End;
  End;
end;

function TNumeroSerie.fMontaSQLReplace_PROSER(strAUTOINCREM, strSER_CODITE, strSER_NUMSER, strSER_CODEMP: string): String;
Begin
  Result := '';
  Result := Result + 'REPLACE INTO PROSER (AUTOINCREM, SER_CODITE, SER_NUMSER, SER_CODEMP) VALUES (';
  Result := Result + QuotedStr(strAUTOINCREM) + ',';
  Result := Result + QuotedStr(strSER_CODITE) + ',';
  Result := Result + QuotedStr(strSER_NUMSER) + ',';
  Result := Result + QuotedStr(strSER_CODEMP) + ');';
End;

function TNumeroSerie.fInsertProdutoSerie: Boolean;
var strAutInc: string;
begin
  Try
    Result := True;
    qrySeries.First;
    strAutInc := fRetAutoIncrem('PROSER', FCodEmpresa, qrySeries.RecordCount);
    FqryGen.SQL.Clear;
    While Not qrySeries.Eof Do
    Begin
      FqryGen.SQL.Add(fMontaSQLReplace_PROSER(strAutInc,
                                              qrySeries.FieldByName('SER_CODITE').AsString,
                                              qrySeries.FieldByName('SER_NUMSER').AsString,
                                              FCodEmpresa));

      qrySeries.Next;
      pIncrementaAutoIncrem(strAutInc);
    End;
    If Not fEmptyStr(FqryGen.SQL.Text) Then
      FqryGen.ExecSQL;
  Except
    On E: Exception do
    Begin
      pMensagensErro(E.message, 'TNumeroSerie.fInsertProdutoSerie');
      Result := False;
    End;

  End;
end;

function TNumeroSerie.fMontaSQLReplace_PROSER(strAUTOINCREM, strSER_CODITE,
  strSER_NUMSER, strSER_CODEMP, strSER_AJUSTE: string): String;
begin
  Result := '';
  Result := Result + 'REPLACE INTO PROSER (AUTOINCREM, SER_CODITE, SER_NUMSER, SER_CODEMP, SER_AJUSTE) VALUES (';
  Result := Result + QuotedStr(strAUTOINCREM) + ',';
  Result := Result + QuotedStr(strSER_CODITE) + ',';
  Result := Result + QuotedStr(strSER_NUMSER) + ',';
  Result := Result + QuotedStr(strSER_CODEMP) + ',';
  Result := Result + QuotedStr(strSER_AJUSTE) + ');';
end;

function TNumeroSerie.fGetSQL: string;
begin
  case FTipoProcesso of
    tpCadProduto: Result := fGetSQLCadProdutos;
    tpEntrada, tpSaida: Result := fGetSQLMovimento;
  end;
End;

function TNumeroSerie.fGetSQLCadProdutos: string;
begin
  Result :=  Result + 'SET @LINHA := 0; ';
  Result :=  Result + 'SELECT @LINHA := @LINHA + 1 AS LINHA, ';
  Result :=  Result + '       SER_CODITE , ';
  Result :=  Result + '       SER_NUMSER, 0 AS MARCADO ';
  Result :=  Result + '  FROM PROSER WHERE SER_CODITE = ' + QuotedStr(FCodProduto);
  Result :=  Result + '   AND SER_CODEMP = ' + QuotedStr(FCodEmpresa);
end;

function TNumeroSerie.fGetSQLMovimento: String;
begin
  If FTipoProcesso = tpEntrada Then
  Begin
    If FTipoRotina = tpEntradaSimplificada Then
    Begin
      Result :=  Result + '  SET @LINHA := 0;                    ';
        Result :=  Result + '  SELECT                            ';
        Result :=  Result + '    @LINHA := @LINHA + 1 AS LINHA,  ';
        Result :=  Result + '    D.DET_CODITE AS SER_CODITE,     ';
        Result :=  Result + '    SER_NUMSER AS SER_NUMSER,       ';
        Result :=  Result + '    1 AS MARCADO                    ';
        Result :=  Result + '  FROM                              ';
        Result :=  Result + '    MOVDET AS D                     ';
        Result :=  Result + '    INNER JOIN DETSER               ';
        Result :=  Result + '    ON SER_SEQGER = D.AUTOINCREM    ';
        Result :=  Result + '   AND D.AUTOINCREM = ' + QuotedStr(FAutoIncremMovDetTE);
    End
    Else If FTipoRotina = tpEnderecamento Then
    Begin
      If Not fExisteEntSer Then
      Begin
        Result :=  Result + 'SET @LINHA := 0; ';
        Result :=  Result + 'SELECT @LINHA := @LINHA + 1 AS LINHA, TMP.SER_CODITE, TMP.SER_NUMSER, 0 AS MARCADO ';
        Result :=  Result + '  FROM (SELECT  D.DET_CODITE AS SER_CODITE , CONVERT("", CHAR(30)) AS SER_NUMSER ';
        Result :=  Result + '          FROM MOVDET AS D ';
        Result :=  Result + '          JOIN (SELECT @ROW := @ROW + 1 AS ROW_ FROM ';
        Result :=  Result + '               (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t, ';
        Result :=  Result + '               (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2, ';
        Result :=  Result + '               (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t3, ';
        Result :=  Result + '               (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t4, ';
        Result :=  Result + '               (SELECT @row:=0) R) N  ON D.DET_QTDITE  - (SELECT COUNT(1) FROM DETSER WHERE SER_SEQGER = ' + QuotedStr(FAutoincrem) + ')>= N.ROW_ ';
        Result :=  Result + ' WHERE D.AUTOINCREM = ' + QuotedStr(FAutoincrem);
        Result :=  Result + ' UNION ALL ';
        Result :=  Result + 'SELECT D.DET_CODITE AS SER_CODITE, SER_NUMSER  ';
        Result :=  Result + '  FROM MOVDET AS D ';
        Result :=  Result + ' INNER JOIN DETSER ON  SER_SEQGER = D.AUTOINCREM ';
        Result :=  Result + '   AND D.AUTOINCREM = ' + QuotedStr(FAutoincrem) + ') AS TMP ';
      End
      Else
      Begin
        Result :=  Result + '  SET @LINHA := 0;                  ';
        Result :=  Result + '  SELECT                            ';
        Result :=  Result + '    @LINHA := @LINHA + 1 AS LINHA,  ';
        Result :=  Result + '    FD.FDO_CODITE AS SER_CODITE,    ';
        Result :=  Result + '    ENT_NUMSER AS SER_NUMSER,       ';
        Result :=  Result + '    1 AS MARCADO                    ';
        Result :=  Result + '  FROM                              ';
        Result :=  Result + '    FATDOR AS FD                    ';
        Result :=  Result + '    INNER JOIN ENTSER               ';
        Result :=  Result + '    ON ENT_SEQFDO = FD.AUTOINCREM   ';
        Result :=  Result + '   AND FD.AUTOINCREM = ' + QuotedStr(FAutoIncremFatDor);
      End;
    End;
  End;
end;

procedure TNumeroSerie.pVisualizaNumerosDeSerie;
var bkpDados: OleVariant;
begin
  If (qrySeries.IsEmpty) And (fEmptyStr(FAutoIncremFatDor)) Then
  Begin
    fMensagem('Atenção', 'Não há números de série para ser exibido.', ['&OK']);
    Exit;
  End;

  If Not Assigned(frmNumeroSerie) Then
    pCriarFormularios(TfrmNumeroSerie, frmNumeroSerie);

  case FTipoProcesso of
    tpEntrada:    frmNumeroSerie.ModoAbertura := maEntrada;
    tpSaida:      frmNumeroSerie.ModoAbertura := maSaida;
    tpCadProduto: frmNumeroSerie.ModoAbertura := maCadProduto;
  End;

  case FTipoProcesso of
    tpEntrada,
    tpSaida: Begin
               bkpDados := qrySeries.Data;;
               frmNumeroSerie.Caption := 'Informe os Números de Serie - Cód Produto: ' + qrySeries.FieldByName('SER_CODITE').AsString;
             End;
    tpCadProduto: frmNumeroSerie.Caption := 'Números de Serie - Cód Produto: ' + qrySeries.FieldByName('SER_CODITE').AsString;
  End;

  frmNumeroSerie.dtsDados.DataSet := qrySeries;
  frmNumeroSerie.blnSomenteLeitura := (Not fEmptyStr(FAutoIncremFatDor) And fExisteEntSer);
  frmNumeroSerie.blnDevolucao := FBlnDevolucao;

  If (Not (frmNumeroSerie.ShowModal = mrOk)) And
     ((FTipoProcesso = tpEntrada) Or (FTipoProcesso = TpSaida)) Then
    qrySeries.Data := bkpDados;
  SeriesUtlizadas.Clear;
  qrySeries.First;
  While Not qrySeries.Eof Do
  begin
    If Not fEmptyStr(qrySeries.FieldByName('SER_NUMSER').AsString) Then
      SeriesUtlizadas.Add(qrySeries.FieldByName('SER_CODITE').AsString + '-' + qrySeries.FieldByName('SER_NUMSER').AsString);
    qrySeries.Next;
  End;

end;

function TNumeroSerie.fTodosItensDefinidos: Boolean;
begin
  If qrySeries.IsEmpty Then
    Exit(False)
  Else
  Begin
    qrySeries.Filtered := False;
    qrySeries.Filter := 'SER_NUMSER = ' + QuotedStr('');
    qrySeries.Filtered := True;
    Result := qrySeries.IsEmpty;
    qrySeries.Filtered := False;
    qrySeries.Filter := '';
  End;
end;

function TNumeroSerie.fSalva(): Boolean;
begin
  Result := False;
  If (FTipoProcesso = tpEntrada)  Then
  Begin
    If (Not fTodosItensDefinidos) And (FTipoRotina = tpEnderecamento) Then
      raise ExceptionNumeroSerie.create('TNumeroSerie.fSalva', 'Em um ou mais produtos não foi definido o Número de Série!');

    Try
      Result := fAtualizaTabela_ProdutosSerie;
      Result := Result And fAtualizaTabela_MovimentoSerie;
    Except
      On E: Exception do
      Begin
        pMensagensErro(E.message, 'TNumeroSerie.fSalva');
        Result := False;
      End;
    End;
  End;
end;

destructor TNumeroSerie.Destroy;
begin
  If Assigned(qrySeries) Then
    FreeAndNil(qrySeries);
  If Assigned(frmNumeroSerie) Then
    FreeAndNil(frmNumeroSerie);
  FreeAndNil(FqryGen);
  FreeAndNil(FQryConsulta);
  FreeAndNil(FQryDelete);
  FreeAndNil(SeriesUtlizadas);
end;

function TNumeroSerie.fExisteEntSer: Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ENT_NUMSER FROM ENTSER WHERE ENT_SEQFDO = :AUTINC');
    qryAux.ParamByName('AUTINC').AsString := FAutoIncremFatDor;
    qryAux.Open;
    Result := Not fEmptyStr(qryAux.FieldByName('ENT_NUMSER').AsString);
  Finally
    FreeAndNil(qryAux);
  End;
end;

{ TListaSeries }

constructor TListaSeries.Create;
begin
  FListSeries := TList<TNumeroSerie>.Create;
end;

destructor TListaSeries.Destroy;
begin
  pLimpaLista;
  FreeAndNil(FListSeries);
  inherited;
end;

function TListaSeries.fExiste(strNumSer, strCodIte: string; blnGeral: Boolean = False): boolean;
  Var
    obj: TNumeroSerie;
    LSer: String;
begin
  Result := False;
  for obj in FListSeries do
  begin
    If (Not blnGeral) Then
    Begin
      Result := obj.SeriesUtlizadas.IndexOf(strCodIte + '-' + strNumSer) > -1;
      If Result Then
        Exit;
    End
    Else
    Begin
      For LSer In obj.SeriesUtlizadas Do
      Begin
        Result := Pos(strNumSer, LSer) > 0;
        If Result Then
          Exit;
      End;
    End;
  End;
end;

function TListaSeries.GetNumeroSerie(AAutoincremIndex: String): TNumeroSerie;
  var obj: TNumeroSerie;
begin
  Result := Nil;
  for obj in FListSeries do
  Begin
    If obj.Autoincrem = AAutoincremIndex Then
    Begin
      If obj.qrySeries.IsEmpty Then
        obj.pAbreCDS;
      Result := obj;
      If Assigned(obj) Then
        If Assigned(frmNumeroSerie) Then
          frmNumeroSerie.ListaSeries := Self;
      break
    End;
  End;
end;

procedure TListaSeries.LimparLista;
begin
  pLimpaLista;
  FreeAndNil(FListSeries);
  FListSeries := TList<TNumeroSerie>.Create;
end;

procedure TListaSeries.pAdd(AAutoincrem: String; ATipoProcesso: TTipoProcesso; AStrAutIncMovDetTE: String = ''; AStrAutIncFatDor: String = ''; ABlnDevolucao: Boolean = False);
  var
    obj: TNumeroSerie;
begin
  obj := TNumeroSerie.Create;
  obj.pInicia(AAutoincrem, ATipoProcesso, AStrAutIncMovDetTE, AStrAutIncFatDor, ABlnDevolucao);
  FListSeries.Add(obj);
end;

procedure TListaSeries.pLimpaLista;
var i: TNumeroSerie;
    x: TNumeroSerie;
begin
  For i in FListSeries do
  Begin
    FListSeries.Remove(i);
    x := i;
    FreeAndNil(x);
  End;
end;

{ ExceptionNumeroSerie }

constructor ExceptionNumeroSerie.create(AMessage, ALocal: String);
begin
  inherited Create(AMessage);
  Self.Local := ALocal;
end;

end.
