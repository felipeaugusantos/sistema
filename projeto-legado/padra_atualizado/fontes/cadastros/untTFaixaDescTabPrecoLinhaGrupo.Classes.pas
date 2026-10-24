unit untTFaixaDescTabPrecoLinhaGrupo.Classes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet, UniDataSetProvider, untFuncoesSimples,
{$ENDIF}
  Classes, DB, Uni;

Type
  TValidacaoCampo = (vcMargem, vcFaturamento);
  TAcaoObjeto     = (aoInserindo, aoEditando, aoDeletando);

Type
  TComissaoFaixaDescTabPrecoLinhaGrupoBuilder = Class (TComponent)
  Private
    FCodigoTabela       : String;
    FDescricao          : String;
    FAutInc             : String;
    FCodigoTabelaPreco  : String;
    FDescontoInicial    : Double;
    FDescontoFinal      : Double;
    FComissaoVista      : Double;
    FComissaoPrazo      : Double;
    FblnUsaProCod       : Boolean;
    FobjTipoAcao        : TAcaoObjeto;
    FcdsLinhaGrupo      : TUniClientDataSet;
    FCodigoLinhaGrupo   : String;
    FNomeLinhaGrupo     : String;

    procedure pAfterOpen(Dataset: TDataSet);
    function fGetListaLinhaGrupo : String;

  Public
    qryDados : TUniQuery;
    cdsDados : TUniClientDataSet;
    cpvDados : TUniDataSetProvider;
    qryTabela: TUniQuery;

    Property CodigoTabela      : String             Read FCodigoTabela       Write FCodigoTabela;
    Property Descricao         : String             Read FDescricao          Write FDescricao;
    Property AutInc            : String             Read FAutInc             Write FAutInc;
    Property CodigoTabelaPreco : String             Read FCodigoTabelaPreco  Write FCodigoTabelaPreco;
    Property DescontoInicial   : Double             Read FDescontoInicial    Write FDescontoInicial;
    Property DescontoFinal     : Double             Read FDescontoFinal      Write FDescontoFinal;
    Property ComissaoVista     : Double             Read FComissaoVista      Write FComissaoVista;
    Property ComissaoPrazo     : Double             Read FComissaoPrazo      Write FComissaoPrazo ;
    Property blnUsaProCod      : Boolean            Read FblnUsaProCod       Write FblnUsaProCod;
    Property objTipoAcao       : TAcaoObjeto        Read FobjTipoAcao        Write FobjTipoAcao;
    Property cdsLinhaGrupo     : TUniClientDataSet  Read FcdsLinhaGrupo;
    Property CodigoLinhaGrupo  : String             Read FCodigoLinhaGrupo   Write FCodigoLinhaGrupo;
    Property NomeLinhaGrupo    : String             Read FNomeLinhaGrupo     Write FNomeLinhaGrupo;

    function fExcluiRegistro: Boolean;
    procedure pAtualizaDados;
    procedure pAtualizaTabela;
    procedure pDeletaItem;
    procedure pInsereDados;
    procedure pAlteraDados;
    function fAtualizaRegistros(var AMensagem : string) : Boolean;
    function fExisteProCodCadastrado(ACodPro: String): Boolean;

    function fValidaDesconto(AValor: Double): Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;

    function fValidarLinhaGrupoJaExiste(ACodigoLinhaGrupo : String; var AMensagem : String) : Boolean;
    function fAdicionarLinhaGrupo(var AMensagem : string) : Boolean;
    procedure pSalvarDadosLinhaGrupo;
    procedure pExcluiLinhaGrupo;
    procedure pCarregaDadosLinhaGrupo;
    function fValidarTabelaPreco(ACodigoFaixa, ATabelaPreco : String; var AMensagem : string) : Boolean;

  end;

  TComissaoFaixaDescTabPrecoLinhaGrupoDAO = class(TObject)
  public
    class function fLinhaGrupoJaAdcionadoEmOutraTabelaPreco(ALinhaGrupo, ACodigoTabela, ATabelaPreco : string;
      var AMensagem : string): Boolean;
    class function fGetPercentualDesconto(ATabelaPreco, ALinhaGrupoItem : string;
      APercentualDesconto : Double; APagamentoAVista : Boolean) : Double;
  end;


implementation

uses SysUtils, Variants, Math;

{ TComissaoFaixaDescTabPrecoLinhaGrupoBuilder }

constructor TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.Create(Owner: TComponent);
begin
  Try
    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryDados                 := fCriaQuery(Self);
    cdsDados                 := TUniClientDataSet.Create(Self);
    cpvDados                 := TUniDataSetProvider.Create(Self);
    cpvDados.DataSet         := qryDados;
    cdsDados.AfterOpen       := pAfterOpen;
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_DESINI;COM_DESFIM';

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM COMFLG WHERE FALSE');
    qryTabela.Open;
    pAtualizaDados;

    FCodigoTabela      := '';
    FDescricao         := '';
    FCodigoTabelaPreco := '';
    FDescontoInicial   := 0;
    FDescontoFinal     := 0;
    FComissaoVista     := 0;
    FComissaoPrazo     := 0;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto COMFLG!' + #13 + E.Message);
  End;

end;

function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fExcluiRegistro: Boolean;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * FROM COMFLG WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := CodigoTabela;
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade(Self.Name, 'COMFLG', qryTmp, True);
          Next;
        End;

        Close;
        SQL.Clear;
        SQL.Add(' DELETE FROM COMFLG WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := CodigoTabela;
        ExecSQL;
        Close;

        Close;
        SQL.Clear;
        SQL.Add(' DELETE FROM COMLGD WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := CodigoTabela;
        ExecSQL;
        Close;
      End;
    End;

    Result := True;
  Except
    On E: Exception Do
    begin
      Raise Exception.Create(E.Message + '[fExcluiRegistro]');
    end;
  End;

  FreeAndNil(qryTmp);
end;

function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fValidaDesconto(AValor: Double): Boolean;
  Var
    Marca: TBookMark;

  function fVerificaCampo(qryDataSet: TDataSet): Boolean;
  Begin
    Result := True;

    With qryDataSet Do
    Begin
      First;

      While Not Eof Do
      Begin
        If SameText(FieldByName('AUTOINCREM').AsString, AutInc) Then
        Begin
          Next;
          Continue;
        End;

        If (RoundTo(AValor, -3) >= RoundTo(FieldByName('COM_DESINI').AsFloat, -3)) And
           (RoundTo(AValor, -3) <= RoundTo(FieldByName('COM_DESFIM').AsFloat, -3)) Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;
    End;
  End;
begin

  Try
    With cdsDados Do
    Begin
      Marca := GetBookmark;
      DisableControls;

      Result := fVerificaCampo(cdsDados);

      If (Not Result) Then
        fMensagem('ATENÇÃO', 'Já existe um registro para esse valor de desconto!', ['&Ok']);

      GotoBookmark(Marca);
      FreeBookmark(Marca);
      EnableControls;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fValidaDesconto]');
  End;
end;

function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fValidarLinhaGrupoJaExiste(ACodigoLinhaGrupo: String; var AMensagem: String): Boolean;
begin
  if not Assigned(FcdsLinhaGrupo) then
    Exit(False);

  Result := FcdsLinhaGrupo.Locate('COM_CODGRU', ACodigoLinhaGrupo,[]);
  if Result then
    AMensagem := 'Linha\Grupo já foi adicionada!';
end;

function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fValidarTabelaPreco(ACodigoFaixa, ATabelaPreco: String; var AMensagem : string): Boolean;
  Var
    LqryTmp: TUniQuery;
    LListaLinhaGrupo : String;
Begin
  Result := True;

  LListaLinhaGrupo := fGetListaLinhaGrupo;
  if fEmptyStr(LListaLinhaGrupo) then
    Exit;

  Try
    LqryTmp := fCriaQuery(Self);
    LqryTmp.Close;
    LqryTmp.SQL.Clear;
    LqryTmp.SQL.Add(' SELECT SQL_NO_CACHE DISTINCT CONCAT(G.COM_CODTAB,'' - '', G.COM_DESCRI) DESCRICAO '+
                    '   FROM COMFLG G '+
                    '   JOIN COMLGD D ON G.COM_CODTAB = D.COM_CODTAB '+
                    '                AND D.COM_CODGRU IN ('+LListaLinhaGrupo+') '+
                    '   WHERE G.COM_TABPRE  = :TABPRE '+
                    '     AND G.COM_CODTAB <> :CODTAB ');
    LqryTmp.ParamByName('TABPRE').AsString := ATabelaPreco;
    LqryTmp.ParamByName('CODTAB').AsString := ACodigoFaixa;
    LqryTmp.Open;
    if not LqryTmp.IsEmpty then
    begin
      Result := False;
      AMensagem := 'Tabela de preço já vinculada a faixa de valores "'+LqryTmp.FieldByName('DESCRICAO').AsString+'" para alguma das linhas\grupos '+
      'informada(s) na faixa atual.';
    end;
    LqryTmp.Close;

  Finally
    FreeAndNil(LqryTmp);
  End;

end;

function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fAdicionarLinhaGrupo(var AMensagem : string) : Boolean;
begin
  Result := True;

  if not Assigned(FcdsLinhaGrupo) then
    pCarregaDadosLinhaGrupo;

  if TComissaoFaixaDescTabPrecoLinhaGrupoDAO.
    fLinhaGrupoJaAdcionadoEmOutraTabelaPreco(FCodigoLinhaGrupo, FCodigoTabela, FCodigoTabelaPreco, AMensagem) then
    Exit(False);

  FcdsLinhaGrupo.Append;
  FcdsLinhaGrupo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMLGD',VS_strCodEmp);
  FcdsLinhaGrupo.FieldByName('COM_CODTAB').AsString := FCodigoTabela;
  FcdsLinhaGrupo.FieldByName('COM_CODGRU').AsString := FCodigoLinhaGrupo;
  FcdsLinhaGrupo.FieldByName('COM_NOMGRU').AsString := FNomeLinhaGrupo;
  FcdsLinhaGrupo.Post;
end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pAfterOpen(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_DESINI')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_DESFIM')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_COMAVI')).DisplayFormat := '#,##0.000';
  TFloatField(Dataset.FieldByName('COM_COMAPR')).DisplayFormat := '#,##0.000';
end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pAlteraDados;
begin
  Try
    With cdsDados Do
    Begin
      If Locate('AUTOINCREM', AutInc, []) Then
      Begin
        Edit;
        FieldByName('COM_COMAVI').AsFloat  := FComissaoVista;
        FieldByName('COM_COMAPR').AsFloat  := FComissaoPrazo;
        FieldByName('COM_DESINI').AsFloat  := FDescontoInicial;
        FieldByName('COM_DESFIM').AsFloat  := FDescontoFinal;
        Post;
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[pAlteraDados]');
  End;
end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pAtualizaDados;
begin

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMFLG WHERE COM_CODTAB = :CODTAB');
    ParamByName('CODTAB').AsString := qryTabela.FieldByName('COM_CODTAB').AsString;
    Open;

    pSetaClient(qryDados);

    cdsDados.Close;
    cdsDados.SetProvider(cpvDados);
    cdsDados.Open;

    If (Not cdsDados.IsEmpty) Then
    Begin
      If fEmptyStr(CodigoTabela) Then
        CodigoTabela := cdsDados.FieldByName('COM_CODTAB').AsString;

      If fEmptyStr(Descricao) Then
        Descricao := cdsDados.FieldByName('COM_DESCRI').AsString;

      If fEmptyStr(CodigoTabelaPreco) Then
        CodigoTabelaPreco := cdsDados.FieldByName('COM_TABPRE').AsString;

      If (qryTabela.State = dsInsert) Then
      Begin
        qryTabela.FieldByName('COM_CODTAB').AsString := cdsDados.FieldByName('COM_CODTAB').AsString;
        qryTabela.FieldByName('COM_DESCRI').AsString := cdsDados.FieldByName('COM_DESCRI').AsString;
        qryTabela.FieldByName('COM_TABPRE').AsString := cdsDados.FieldByName('COM_TABPRE').AsString;
        qryTabela.FieldByName('COM_DESINI').AsFloat  := cdsDados.FieldByName('COM_DESINI').AsFloat;
        qryTabela.FieldByName('COM_DESFIM').AsFloat  := cdsDados.FieldByName('COM_DESFIM').AsFloat;
      End;

      pCarregaDadosLinhaGrupo;
    End;
  End;
end;

function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fAtualizaRegistros(var AMensagem : string) : Boolean;
  Var
    intRecNo: Integer;
begin
  Result := True;

  if (not Assigned(FcdsLinhaGrupo)) or (FcdsLinhaGrupo.RecordCount = 0) then
  begin
    AMensagem := 'É necessário informar ao menos uma linha\grupo para gravar as faixas desta comissão.';
    Exit(False);
  end;

  intRecNo := cdsDados.RecNo;

  Try
    cdsDados.IndexFieldNames := '';
    cdsDados.DisableControls;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('COM_CODTAB').AsString := FCodigoTabela;
      cdsDados.FieldByName('COM_DESCRI').AsString := FDescricao;
      cdsDados.FieldByName('COM_TABPRE').AsString := FCodigoTabelaPreco;
      cdsDados.Post;
      cdsDados.Next;
    End;

    cdsLinhaGrupo.First;
    While Not cdsLinhaGrupo.Eof Do
    Begin
      cdsLinhaGrupo.Edit;
      cdsLinhaGrupo.FieldByName('COM_CODTAB').AsString := FCodigoTabela;
      cdsLinhaGrupo.Post;
      cdsLinhaGrupo.Next;
    End;

  Finally
    cdsDados.IndexFieldNames := 'COM_CODTAB;COM_DESINI;COM_DESFIM';
    cdsDados.RecNo := intRecNo;
    cdsDados.EnableControls;
  End;

end;

function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fExisteProCodCadastrado(ACodPro: String): Boolean;
  Var
    qryTmp: TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery(Self);

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM COMFLG WHERE COM_CODTAB = :CODTAB');
      ParamByName('CODTAB').AsString := ACodPro;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
End;


function TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.fGetListaLinhaGrupo: String;
begin
  FcdsLinhaGrupo.DisableControls;
  FcdsLinhaGrupo.First;
  while not FcdsLinhaGrupo.Eof do
  begin
    if fEmptyStr(Result) then
      Result := QuotedStr(FcdsLinhaGrupo.FieldByName('COM_CODGRU').AsString)
    else
      Result := Result +', '+ QuotedStr(FcdsLinhaGrupo.FieldByName('COM_CODGRU').AsString);

    FcdsLinhaGrupo.Next;
  end;
  FcdsLinhaGrupo.EnableControls;
end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pAtualizaTabela;
begin

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMFLG WHERE COM_CODTAB = :CODTAB');
    ParamByName('CODTAB').AsString := FCodigoTabela;
    Open;
  End;

end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pCarregaDadosLinhaGrupo;
  var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Sql.Text := 'SELECT C.* , '+
                       '  CONCAT((SELECT L.GRU_DESGRU FROM CADGRU L WHERE L.GRU_CODGRU = CONCAT(LEFT(G.GRU_CODGRU, 3), "000")),'' / '', G.GRU_DESGRU) COM_NOMGRU '+
                       '  FROM COMLGD C '+
                       '  JOIN CADGRU G ON C.COM_CODGRU = G.GRU_CODGRU '+
                       ' WHERE C.COM_CODTAB = :CODTAB ';
    LQuery.ParamByName('CODTAB').AsString:= qryTabela.FieldByName('COM_CODTAB').AsString;
    LQuery.Open;
    FcdsLinhaGrupo := fCriaClientDatset(LQuery);
    LQuery.Close;
  Finally
    FreeAndNil(LQuery)
  End;
end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pDeletaItem;
begin

  Try
    If cdsDados.IsEmpty Then
      Exit;

    cdsDados.Delete;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pExcluiLinhaGrupo;
begin
  Try
    If FcdsLinhaGrupo.IsEmpty Then
      Exit;
    FcdsLinhaGrupo.Delete;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pInsereDados;
begin
  Try
    With cdsDados Do
    Begin
      Append;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMFLG',VS_strCodEmp);
      FieldByName('COM_CODTAB').AsString := FCodigoTabela;
      FieldByName('COM_TABPRE').AsString := FCodigoTabelaPreco;
      FieldByName('COM_DESCRI').AsString := FDescricao;
      FieldByName('COM_COMAVI').AsFloat  := FComissaoVista;
      FieldByName('COM_COMAPR').AsFloat  := FComissaoPrazo;
      FieldByName('COM_DESINI').AsFloat  := FDescontoInicial;
      FieldByName('COM_DESFIM').AsFloat  := FDescontoFinal;
      Post;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.pSalvarDadosLinhaGrupo;
  var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := ' DELETE FROM COMLGD WHERE COM_CODTAB = :CODTAB';
    LQuery.ParamByName('CODTAB').AsString := CodigoTabela;
    LQuery.ExecSQL;

    if not Assigned(FcdsLinhaGrupo) then
      Exit;

    LQuery.Sql.Clear;
    LQuery.Sql.Text := ' REPLACE INTO COMLGD (AUTOINCREM, COM_CODTAB, COM_CODGRU) VALUES '+
                       ' (:AUTINC, :CODTAB, :CODGRU) ';
    FcdsLinhaGrupo.First;
    while not FcdsLinhaGrupo.Eof do
    begin
      LQuery.ParamByName('AUTINC').AsString := FcdsLinhaGrupo.FieldByName('AUTOINCREM').AsString;
      LQuery.ParamByName('CODTAB').AsString := FcdsLinhaGrupo.FieldByName('COM_CODTAB').AsString;
      LQuery.ParamByName('CODGRU').AsString := FcdsLinhaGrupo.FieldByName('COM_CODGRU').AsString;
      LQuery.ExecSql;

      FcdsLinhaGrupo.Next;
    end;
  Finally
    FreeAndNil(LQuery)
  End;
end;

{ TComissaoFaixaDescTabPrecoLinhaGrupoDAO }

class function TComissaoFaixaDescTabPrecoLinhaGrupoDAO.fGetPercentualDesconto(ATabelaPreco, ALinhaGrupoItem: string; APercentualDesconto: Double;
  APagamentoAVista: Boolean): Double;
  var
    Lquery : TUniQuery;
begin
  Result := 0.00;

  LQuery := fCriaQuery(Nil);
  Try
   Lquery.Sql.add('SELECT ');

   if APagamentoAVista then
     Lquery.Sql.add('COMFLG.COM_COMAVI COMISSAO ')
   else
     Lquery.Sql.add('COMFLG.COM_COMAPR COMISSAO ');

   Lquery.Sql.add('  FROM COMFLG '+
                  '  JOIN COMLGD ON COMFLG.COM_CODTAB = COMLGD.COM_CODTAB '+
                  '             AND COMLGD.COM_CODGRU = :CODGRU '+
                  ' WHERE COMFLG.COM_TABPRE = :TABPRE '+
                  '   AND :DESCON BETWEEN COMFLG.COM_DESINI AND COMFLG.COM_DESFIM ');
    Lquery.ParamByName('TABPRE').AsString := ATabelaPreco;
    Lquery.ParamByName('CODGRU').AsString := ALinhaGrupoItem;
    Lquery.ParamByName('DESCON').AsFloat  := APercentualDesconto;
    Lquery.Open;
    if not LQuery.IsEmpty then
      Result := Lquery.FieldByName('COMISSAO').AsFloat;
    Lquery.Close;
  Finally
    FreeAndNil(LQuery)
  End;
end;

class function TComissaoFaixaDescTabPrecoLinhaGrupoDAO.fLinhaGrupoJaAdcionadoEmOutraTabelaPreco(ALinhaGrupo, ACodigoTabela, ATabelaPreco: string;
  var AMensagem: string): Boolean;
  Var
    LQuery : TUniQuery;
begin
  Result := False;

  LQuery := fCriaQuery(Nil);
  Try
   Lquery.Sql.add(' SELECT CONCAT(COMFLG.COM_CODTAB,'' - '',COMFLG.COM_DESCRI) TABELA '+
                  '  FROM COMFLG '+
                  '  JOIN COMLGD ON COMFLG.COM_CODTAB = COMLGD.COM_CODTAB '+
                  '             AND COMLGD.COM_CODGRU = :CODGRU '+
                  ' WHERE COMFLG.COM_CODTAB <> :CODTAB '+
                  '   AND COMFLG.COM_TABPRE = :TABPRE ');
    LQuery.ParamByName('CODGRU').AsString  := ALinhaGrupo;
    LQuery.ParamByName('CODTAB').AsString  := ACodigoTabela;
    LQuery.ParamByName('TABPRE').AsString  := ATabelaPreco;
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      Amensagem := 'Linha/grupo já adicionada à outro grupo ('+Lquery.FieldByName('TABELA').AsString+') para esta mesma tabela de preço. Favor revisar!';
      Exit(True);
    end;
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
