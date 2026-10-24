unit untTImpulsionadorVendasCRM;

interface

uses Classes, SysUtils, StrUtils, Generics.Collections, Aurelius.Bind.Dataset,
  DB, System.Generics.Defaults, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Controls, untTypesSistema, Vcl.ExtCtrls, UniClientDataSet, Uni, EditFocus,
  Types, Vcl.Graphics, CRAccess, System.Variants, MemoFocus, Vcl.ComCtrls,
  untIZClient, System.DateUtils, MaskEditFocus;

Type
  TAfterScrollResumoVendas = Procedure(DataSet: TDataSet) Of Object;
  TBeforePostResumoVendas  = Procedure(DataSet: TDataSet) Of Object;

  TPeriodoAnalise = Record
    strDescMes1: String;
    dteDtaIni_1: TDateTime;
    dteDtaFin_1: TDateTime;

    strDescMes2: String;
    dteDtaIni_2: TDateTime;
    dteDtaFin_2: TDateTime;

    strDescMes3: String;
    dteDtaIni_3: TDateTime;
    dteDtaFin_3: TDateTime;

    strDescMes4: String;
    dteDtaIni_4: TDateTime;
    dteDtaFin_4: TDateTime;

    strDescMes5: String;
    dteDtaIni_5: TDateTime;
    dteDtaFin_5: TDateTime;

    strDescMes6: String;
    dteDtaIni_6: TDateTime;
    dteDtaFin_6: TDateTime;

    strDescMes7: String;
    dteDtaIni_7: TDateTime;
    dteDtaFin_7: TDateTime;
  End;

  TImpulsionadorVendasCRM = Class(TObject)
  Private
    FCdsVendas: TUniClientDataSet;

    FCodCli: String;
    FTabPre: String;
    FPeriodoAnalise: TPeriodoAnalise;
    FMarca: String;
    FFornec: String;
    FLinGrupo: String;
    FGruProd: String;
    FCodDep: String;

    FEdtCodFor: TEditFocus;
    FEdtCodMar: TEditFocus;
    FEdtLinGru: TEditFocus;
    FEdtCadGru: TEditFocus;
    FEdtCodDep: TEditFocus;
    FMskDtaIni: TMaskEditFocus;
    FMskDtaFin: TMaskEditFocus;

    FIncluiuProdutosOrc: Boolean;

    FAterScrollResumoVendas: TAfterScrollResumoVendas;
    FBeforePostResumoVendas: TBeforePostResumoVendas;

    FDtaIniAnalise,
    FDtaFinAnalise,
    FDtaPenultimoMesAna: TDateTime;
    FIntNroMeses: Integer;
    FDtaIniUltimoMesAna,
    FDtaFimUltimoMesAna: TDateTime;

    FblnIncIte: Boolean;
    FblnInserirItemManualmente: Boolean;
    FintQtdItensGerarOR: Integer;
    FstrCodIteAtu: String;
    FTipPreco : Integer;

    Procedure pSetCodCli(Value: String);
    Procedure pLimparArraysConsulta;
    Procedure pCriarClientDataSet;
    Procedure pInicializarComponentes;
    Procedure pDefinirPeriodoAnaliseVendas;
    Procedure pDefinirParametrosQuery(qryDados: TUniQuery; strCodIte: String; dteDataIni, dteDataFin: TDateTime);

    Function fGetSQLFiltroProdutosVenda(blnVenda6Meses: Boolean): String;
    Function fGetSQLProdutosOrcPed: String;
    Function fCriarQueryConsultas(strSQL: String): TUniQuery;
    function fRetTabPre(strCodCli: String): String;
    function fRetDataInicialPeriodo(const dtaReferencia: TDateTime; intQtdMeses: Integer = 0): TDateTime;
    function fRetDataFinalPeriodo(const dtaReferencia: TDateTime; intQtdMeses: Integer = 0): TDateTime;
    function fRetDescricaoMes(const aData: TDateTime): String;
    function fRetNroMesesAnalise: Integer;
  Public
    arrFornec: TConsultasArray;
    arrMarca : TConsultasArray;
    arrLinGru: TConsultasArray;
    arrCadGru: TConsultasArray;
    arrDepart: TConsultasArray;

    Constructor Create(ACodcli: String; AAterScrollResumoVendas: TAfterScrollResumoVendas; ABeforePostResumoVendas: TBeforePostResumoVendas;
      AEdtCodFor, AEdtCodMar, AEdtLinGru, AEdtCadGru, AEdtCodDep: TEditFocus; AMskDtaIni, AMskDtaFin: TMaskEditFocus); Reintroduce;

    Function fGetCodCli: String;
    Function fGetTabPre: String;
    Function fGetCdsVendas: TUniClientDataSet;
    Function fFiltrarRegistros: Boolean;
    Function fRealizarOrcamento: Boolean;
    Function fAdicionarProdutosOrcamento(fIncluirItem: TfIncluiItem): Boolean;
    Function fPossuiItensGerarOrcamento: Boolean;
    Procedure pLimparClientDataSet;
    function fValidarFiltroData(AMskDtaIni, AMskDtaFin: TMaskEditFocus): Boolean;
    function fVerificaTodosItensInseridos: Boolean;
    procedure pAtualizarItemInserido(const strCodIte: String);

    Procedure pLimparFiltros;
    Function fRetPrecoVenda(strCodIte: String): Double;

    Property recPeriodoAnalise: TPeriodoAnalise Read FPeriodoAnalise;
    property blnIncIte: Boolean read FblnIncIte write FblnIncIte;
    property blnInserirItemManualmente: Boolean read FblnInserirItemManualmente write FblnInserirItemManualmente;
    property strCodIteAtu: String read FstrCodIteAtu write FstrCodIteAtu;
    property intTipPreco: Integer read FTipPreco write FTipPreco;
  End;

implementation

{ TImpulsionadorVendasCRM }

uses untConstantes, untFuncoesConsulta, untFatVendas, untMensagemExplicativa,
  untMargemMinima;

constructor TImpulsionadorVendasCRM.Create(ACodcli: String; AAterScrollResumoVendas: TAfterScrollResumoVendas; ABeforePostResumoVendas: TBeforePostResumoVendas;
      AEdtCodFor, AEdtCodMar, AEdtLinGru, AEdtCadGru, AEdtCodDep: TEditFocus;
      AMskDtaIni, AMskDtaFin: TMaskEditFocus);
begin
  FblnIncIte := False;
  FblnInserirItemManualmente := False;

  If (fEmptyStr(ACodCli)) Then
    Raise Exception.Create('[TImpulsionadorVendasCRM.Create] Códido do cliente deve ser informado!')
  Else If (Not Assigned(AAterScrollResumoVendas)) Then
    Raise Exception.Create('[TImpulsionadorVendasCRM.Create] Evento de scroll do dataset deve ser informado!')
  Else If (Not Assigned(ABeforePostResumoVendas)) Then
    Raise Exception.Create('[TImpulsionadorVendasCRM.Create] Evento de before post do dataset deve ser informado!')
  Else If (Not Assigned(AEdtCodFor)) Or (Not Assigned(AEdtCodMar)) Or (Not Assigned(AEdtLinGru)) Or (Not Assigned(AEdtCadGru)) Then
    Raise Exception.Create('[TImpulsionadorVendasCRM.Create] Edits de filtro devem ser passados como referência!')
  Else
  Begin
    pSetCodCli(ACodCli);
    FTabPre := fRetTabPre(ACodCli);

    FAterScrollResumoVendas := AAterScrollResumoVendas;
    FBeforePostResumoVendas := ABeforePostResumoVendas;

    FEdtCodFor := AEdtCodFor;
    FEdtCodMar := AEdtCodMar;
    FEdtLinGru := AEdtLinGru;
    FEdtCadGru := AEdtCadGru;
    FEdtCodDep := AEdtCodDep;
    FMskDtaIni := AMskDtaIni;
    FMskDtaFin := AMskDtaFin;

    FIncluiuProdutosOrc := False;

    pInicializarComponentes();
    pLimparArraysConsulta();
  End;
end;

function TImpulsionadorVendasCRM.fVerificaTodosItensInseridos: Boolean;
Var
  intQtdIteInseridos: Integer;
begin
  Try
    Result := False;
    intQtdIteInseridos := 0;
    Try
      FCdsVendas.DisableControls();
      FCdsVendas.First();

      Try
        While (Not FCdsVendas.Eof) Do
        Begin
          If (FCdsVendas.FieldByName('SELECT').AsInteger = 1) And (FCdsVendas.FieldByName('INSORC').AsString = 'S') Then
          Begin
            Inc(intQtdIteInseridos);
          End;

          FCdsVendas.Next();
        End;

        Result := (FintQtdItensGerarOR = intQtdIteInseridos);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.fVerificaTodosItensInseridos]');
      End;
    Finally
      FCdsVendas.EnableControls();
    End;
  Finally
    FCdsVendas.Filtered := False;
  End;
end;

function TImpulsionadorVendasCRM.fAdicionarProdutosOrcamento(fIncluirItem: TfIncluiItem): Boolean;
  Var
    intRecNo: Integer;
    blnInseriuItem : Boolean;
    arrListaNaoInseridos : Array Of String;
begin
  Result := True;
  SetLength(arrListaNaoInseridos, 0);

  If (FIncluiuProdutosOrc) Then
    Exit;

  Try
    With FCdsVendas Do
    Begin
      intRecNo := RecNo;
      AfterScroll := nil;
      DisableControls;
      blnIncIte := True;
      Try
        First();

        While Not Eof Do
        Begin
          FstrCodIteAtu := EmptyStr;
          If (FCdsVendas.FieldByName('SELECT').AsInteger = 1) And (FCdsVendas.FieldByName('INSORC').AsString = 'N') Then
          Begin
            FblnInserirItemManualmente := False;
            blnInseriuItem := fIncluirItem(FCdsVendas.FieldByName('CODITE').AsString,
                                           '',
                                           FCdsVendas.FieldByName('QTDITE').AsFloat);
            If (Not blnInseriuItem) Then
            Begin
              SetLength(arrListaNaoInseridos, Length(arrListaNaoInseridos)+1);
              arrListaNaoInseridos[Length(arrListaNaoInseridos)-1] := FCdsVendas.FieldByName('CODITE').AsString + ' - ' +
                                                                      FCdsVendas.FieldByName('DESCRI').AsString;
            End
            Else If (Not FblnInserirItemManualmente) Then
              pAtualizarItemInserido(FCdsVendas.FieldByName('CODITE').AsString);
          End;

          FCdsVendas.Next;
        End;

        If Length(arrListaNaoInseridos) > 0 Then
        Begin
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          Try
            frmMensagemExplicativa.Caption := 'Não foi possível inserir os itens';
            frmMensagemExplicativa.Width   := 650;
            frmMensagemExplicativa.Height  := 300;
            frmMensagemExplicativa.mmoInstru.Lines.Add(fOrganizaArrayComVirgula(arrListaNaoInseridos, False, sLineBreak));
            frmMensagemExplicativa.ShowModal;
          Finally
            FreeAndNil(frmMensagemExplicativa);
          End;
        End;

        FIncluiuProdutosOrc := fVerificaTodosItensInseridos;
      Finally
        RecNo := intRecNo;
        AfterScroll := FAterScrollResumoVendas;
        EnableControls;
        Result := FIncluiuProdutosOrc;
      End;
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.fAdicionarProdutosOrcamento]');
    End;
  End;
end;

procedure TImpulsionadorVendasCRM.pAtualizarItemInserido(const strCodIte: String);
begin
  FCdsVendas.Locate('CODITE', strCodIte, []);
  FCdsVendas.Edit;
  FCdsVendas.FieldByName('INSORC').AsString := 'S';
  FCdsVendas.Post;
end;

function TImpulsionadorVendasCRM.fCriarQueryConsultas(strSQL: String): TUniQuery;
begin
  Result := nil;

  Try
    Result := fCriaQuery(nil);
    Result.Close();
    Result.SQL.Clear();
    Result.SQL.Text := strSQL;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.pCriarQueryConsultas]');
  End;
end;

function TImpulsionadorVendasCRM.fFiltrarRegistros: Boolean;
  Var
    i: Integer;
    qryProdutosVenda6Meses,
    qryProdutosVendaMesAtual,
    qryDadosOrcPed: TUniQuery;
    stlProdutos: TStringList;
    fltCustoParaMargem : Double;

  procedure pQryProdutosVenda6Meses(blnComValores: Boolean);
  begin
    qryProdutosVenda6Meses := fCriarQueryConsultas(fGetSQLFiltroProdutosVenda(Not blnComValores));

    If (blnComValores) Then
      pDefinirParametrosQuery(qryProdutosVenda6Meses, stlProdutos[i], FPeriodoAnalise.dteDtaIni_1, FDtaFinAnalise)
    Else
      pDefinirParametrosQuery(qryProdutosVenda6Meses, '', FPeriodoAnalise.dteDtaIni_1, FDtaPenultimoMesAna);
  end;

  procedure pQryProdutosVendaMesAtual;
  begin
    qryProdutosVendaMesAtual := fCriarQueryConsultas(fGetSQLFiltroProdutosVenda(True));
    pDefinirParametrosQuery(qryProdutosVendaMesAtual, '', FDtaIniUltimoMesAna, FDtaFimUltimoMesAna);
  end;

  procedure pQryProdutoOrcPed;
  begin
    qryDadosOrcPed := fCriarQueryConsultas(fGetSQLProdutosOrcPed());
    pDefinirParametrosQuery(qryDadosOrcPed, stlProdutos[i], FDtaIniAnalise, FDtaFinAnalise);
  end;

begin
  Result := False;

  Try

    If Not fValidarFiltroData(FMskDtaIni, FMskDtaFin) Then
    Begin
      fMensagem('ATENÇÃO!', 'Permitido Análise de Resumo de Vendas dos Últimos 6 Meses!', ['&Ok']);
      Exit;
    End;

    pDefinirPeriodoAnaliseVendas();

    stlProdutos := TStringList.Create();

    FCdsVendas.EmptyDataSet();

    pQryProdutosVenda6Meses(False);
    pQryProdutosVendaMesAtual();

    Try
      While (Not qryProdutosVenda6Meses.Eof) Do
      Begin
        If (Not qryProdutosVendaMesAtual.Locate('CODITE', qryProdutosVenda6Meses.FieldByName('CODITE').AsString, [])) Then
          stlProdutos.Add(qryProdutosVenda6Meses.FieldByName('CODITE').AsString);

        qryProdutosVenda6Meses.Next();
      End;

      FreeAndNil(qryProdutosVenda6Meses);
      FreeAndNil(qryProdutosVendaMesAtual);

      For i := 0 To stlProdutos.Count - 1 Do
      Begin
        pQryProdutosVenda6Meses(True);
        pQryProdutoOrcPed();

        If (Not qryProdutosVenda6Meses.IsEmpty) And (Not qryDadosOrcPed.IsEmpty) Then
        Begin
          While (Not qryProdutosVenda6Meses.Eof) Do
          Begin
            FCdsVendas.Append();

            FCdsVendas.FieldByName('SELECT').AsInteger := 0;
            FCdsVendas.FieldByName('INSORC').AsString := 'N';

            FCdsVendas.FieldByName('CODITE').AsString  := qryProdutosVenda6Meses.FieldByName('CODITE').AsString;
            FCdsVendas.FieldByName('DESCRI').AsString  := qryProdutosVenda6Meses.FieldByName('DESCRI').AsString;

            FCdsVendas.FieldByName('QTDITE_MES_1').AsFloat := qryProdutosVenda6Meses.FieldByName('QTDITE_MES_1').AsFloat;
            FCdsVendas.FieldByName('VLRITE_MES_1').AsFloat := qryProdutosVenda6Meses.FieldByName('VLRITE_MES_1').AsFloat;
            FCdsVendas.FieldByName('QTDITE_MES_2').AsFloat := qryProdutosVenda6Meses.FieldByName('QTDITE_MES_2').AsFloat;
            FCdsVendas.FieldByName('VLRITE_MES_2').AsFloat := qryProdutosVenda6Meses.FieldByName('VLRITE_MES_2').AsFloat;
            FCdsVendas.FieldByName('QTDITE_MES_3').AsFloat := qryProdutosVenda6Meses.FieldByName('QTDITE_MES_3').AsFloat;
            FCdsVendas.FieldByName('VLRITE_MES_3').AsFloat := qryProdutosVenda6Meses.FieldByName('VLRITE_MES_3').AsFloat;
            FCdsVendas.FieldByName('QTDITE_MES_4').AsFloat := qryProdutosVenda6Meses.FieldByName('QTDITE_MES_4').AsFloat;
            FCdsVendas.FieldByName('VLRITE_MES_4').AsFloat := qryProdutosVenda6Meses.FieldByName('VLRITE_MES_4').AsFloat;
            FCdsVendas.FieldByName('QTDITE_MES_5').AsFloat := qryProdutosVenda6Meses.FieldByName('QTDITE_MES_5').AsFloat;
            FCdsVendas.FieldByName('VLRITE_MES_5').AsFloat := qryProdutosVenda6Meses.FieldByName('VLRITE_MES_5').AsFloat;
            FCdsVendas.FieldByName('QTDITE_MES_6').AsFloat := qryProdutosVenda6Meses.FieldByName('QTDITE_MES_6').AsFloat;
            FCdsVendas.FieldByName('VLRITE_MES_6').AsFloat := qryProdutosVenda6Meses.FieldByName('VLRITE_MES_6').AsFloat;
            FCdsVendas.FieldByName('QTDITE_MES_7').AsFloat := qryProdutosVenda6Meses.FieldByName('QTDITE_MES_7').AsFloat;
            FCdsVendas.FieldByName('VLRITE_MES_7').AsFloat := qryProdutosVenda6Meses.FieldByName('VLRITE_MES_7').AsFloat;

            If (TMargemMinima.UsaPrecoLiquido) Then
            Begin
              If (TMargemMinima.UsaPrecoMedio) Then
                fltCustoParaMargem := qryProdutosVenda6Meses.FieldByName('TOTMED').AsFloat + qryProdutosVenda6Meses.FieldByName('OUTVAL').AsFloat
              Else
                fltCustoParaMargem := ( qryProdutosVenda6Meses.FieldByName('TOTCUS').AsFloat *
                                         ( 1 + (IIF(fCfgSis('JURCUS', VarBoolean), qryProdutosVenda6Meses.FieldByName('TAXJUR').AsFloat, 0) / 100) ) ) +
                                           qryProdutosVenda6Meses.FieldByName('OUTVAL').AsFloat;

              FCdsVendas.FieldByName('MARGEM').AsFloat :=
                fCalculaPrecoVenda(2,
                                   fltCustoParaMargem,
                                   qryProdutosVenda6Meses.FieldByName('TOTITE').AsFloat -
                                     (qryProdutosVenda6Meses.FieldByName('TAXENT').AsFloat / qryProdutosVenda6Meses.FieldByName('QTDITE').AsFloat) -
                                       (qryProdutosVenda6Meses.FieldByName('DESESP').AsFloat / qryProdutosVenda6Meses.FieldByName('QTDITE').AsFloat),
                                   0,
                                   qryProdutosVenda6Meses.FieldByName('ICMSAI').AsFloat,
                                   qryProdutosVenda6Meses.FieldByName('IMPFED').AsFloat,
                                   qryProdutosVenda6Meses.FieldByName('DESOPE').AsFloat,
                                   0)
            End
            Else
            Begin
              If (TMargemMinima.UsaPrecoMedio) Then
                fltCustoParaMargem := qryProdutosVenda6Meses.FieldByName('TOTMED').AsFloat
              Else
                fltCustoParaMargem := ( qryProdutosVenda6Meses.FieldByName('TOTCUS').AsFloat *
                                         ( 1 + (IIF(fCfgSis('JURCUS', VarBoolean), qryProdutosVenda6Meses.FieldByName('TAXJUR').AsFloat, 0) / 100) ) );

              FCdsVendas.FieldByName('MARGEM').AsFloat :=
                fCalculaPrecoVenda(2,
                                   fltCustoParaMargem,
                                   qryProdutosVenda6Meses.FieldByName('TOTITE').AsFloat -
                                     (qryProdutosVenda6Meses.FieldByName('TAXENT').AsFloat / qryProdutosVenda6Meses.FieldByName('QTDITE').AsFloat) -
                                       (qryProdutosVenda6Meses.FieldByName('DESESP').AsFloat / qryProdutosVenda6Meses.FieldByName('QTDITE').AsFloat),
                                   0,
                                   0,
                                   0,
                                   0,
                                   0);
            End;

            While (Not qryDadosOrcPed.Eof) Do
            Begin
              FCdsVendas.FieldByName('UNIDAD').AsString   := qryDadosOrcPed.FieldByName('UNIDAD').AsString;
              FCdsVendas.FieldByName('QTDUVE').AsFloat    := qryDadosOrcPed.FieldByName('QTDUVE').AsFloat;
              FCdsVendas.FieldByName('PREUVE').AsFloat    := qryDadosOrcPed.FieldByName('PREUVE').AsFloat;
              FCdsVendas.FieldByName('QTDITE').AsFloat    := qryDadosOrcPed.FieldByName('QTDUVE').AsFloat;

              if intTipPreco = 1 then
                FCdsVendas.FieldByName('UNITAR').AsFloat := qryDadosOrcPed.FieldByName('PREUVE').AsFloat
              else
                FCdsVendas.FieldByName('UNITAR').AsFloat := fRetPrecoVenda(stlProdutos[i]);


              FCdsVendas.FieldByName('QTDORC').AsFloat    := qryDadosOrcPed.FieldByName('QTDORC').AsFloat;
              FCdsVendas.FieldByName('TOTORC').AsFloat    := qryDadosOrcPed.FieldByName('TOTORC').AsFloat;
              FCdsVendas.FieldByName('QTDPED').AsFloat    := qryDadosOrcPed.FieldByName('QTDPED').AsFloat;
              FCdsVendas.FieldByName('TOTPED').AsFloat    := qryDadosOrcPed.FieldByName('TOTPED').AsFloat;
              FCdsVendas.FieldByName('DTAUVE').AsDateTime := qryDadosOrcPed.FieldByName('DTAUVE').AsDateTime;
              FCdsVendas.FieldByName('NUMDOC').AsString   := qryDadosOrcPed.FieldByName('NUMDOC').AsString;
              FCdsVendas.FieldByName('NVLGIR').AsString   := qryDadosOrcPed.FieldByName('NVLGIR').AsString;

              If (FCdsVendas.FieldByName('QTDITE').AsFloat = 0) Then  FCdsVendas.FieldByName('QTDITE').AsFloat := 1;

              FCdsVendas.FieldByName('TOTITE').AsFloat    := (FCdsVendas.FieldByName('QTDITE').AsFloat * FCdsVendas.FieldByName('UNITAR').AsFloat);

              qryDadosOrcPed.Next;
            End;

            FCdsVendas.Post();

            qryProdutosVenda6Meses.Next();
          End;
        End;

        FreeAndNil(qryProdutosVenda6Meses);
        FreeAndNil(qryDadosOrcPed);
      End;

      Result := (FCdsVendas.RecordCount > 0);
    Except
      On E : Exception Do
	  	  pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.fFiltrarRegistros]');
    End;
  Finally
    FreeAndNil(stlProdutos);
    FreeAndNil(qryProdutosVendaMesAtual);
  End;
end;

function TImpulsionadorVendasCRM.fGetCdsVendas: TUniClientDataSet;
begin
  Result := FCdsVendas;
end;

function TImpulsionadorVendasCRM.fGetCodCli: String;
begin
  Result := FCodCli;
end;

function TImpulsionadorVendasCRM.fGetSQLFiltroProdutosVenda(blnVenda6Meses: Boolean): String;
  Var
    strSQL: String;

  function fGetSelectGroup: string;
  begin
    Result := '';
    Result := ' SELECT DET_CODITE AS CODITE, ';
    Result := Result + '  DET_DESCRI AS DESCRI, ';
    Result := Result + '  SUM(DET_TOTCUS) AS TOTCUS, ';
    Result := Result + '  SUM(DET_TOTMED) AS TOTMED, ';
    Result := Result + '  MAX(DET_TAXJUR) AS TAXJUR, ';
    Result := Result + '  MAX(DET_OUTVAL) AS OUTVAL, ';
    Result := Result + '  MAX(DET_TAXENT) AS TAXENT, ';
    Result := Result + '  SUM(DET_DESESP) AS DESESP, ';
    Result := Result + '  SUM(DET_QTDITE) AS QTDITE, ';
    Result := Result + '  MAX(DET_ICMSAI) AS ICMSAI, ';
    Result := Result + '  MAX(DET_IMPFED) AS IMPFED, ';
    Result := Result + '  MAX(DET_DESOPE) AS DESOPE, ';
    Result := Result + '  SUM(DET_TOTITE - DET_DESESP - DET_DESCFF) AS TOTITE,  ';

    If FPeriodoAnalise.dteDtaIni_1 > 0 Then
    Begin
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_1 AND :DTAFIN_1, DET_QTDITE, 0 ) ) AS QTDITE_MES_1, ';
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_1 AND :DTAFIN_1, (DET_TOTITE - DET_DESESP - DET_DESCFF), 0 ) ) AS VLRITE_MES_1, ';
    End
    Else
    Begin
      Result := Result + ' 0 AS QTDITE_MES_1, ';
      Result := Result + ' 0 AS VLRITE_MES_1, ';
    End;

    If FPeriodoAnalise.dteDtaIni_2 > 0 Then
    Begin
      Result := Result + ' SUM( IF( GER_DTAENT BETWEEN :DTAINI_2 AND :DTAFIN_2, DET_QTDITE, 0 ) ) AS QTDITE_MES_2, ';
      Result := Result + ' SUM( IF( GER_DTAENT BETWEEN :DTAINI_2 AND :DTAFIN_2, (DET_TOTITE - DET_DESESP - DET_DESCFF), 0 ) ) AS VLRITE_MES_2, ';
    End
    Else
    Begin
      Result := Result + ' 0 AS QTDITE_MES_2, ';
      Result := Result + ' 0 AS VLRITE_MES_2, ';
    End;

    If FPeriodoAnalise.dteDtaIni_3 > 0 Then
    Begin
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_3 AND :DTAFIN_3, DET_QTDITE, 0 ) ) AS QTDITE_MES_3, ';
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_3 AND :DTAFIN_3, (DET_TOTITE - DET_DESESP - DET_DESCFF), 0 ) ) AS VLRITE_MES_3, ';
    End
    Else
    Begin
      Result := Result + ' 0 AS QTDITE_MES_3, ';
      Result := Result + ' 0 AS VLRITE_MES_3, ';
    End;

    If FPeriodoAnalise.dteDtaIni_4 > 0 Then
    Begin
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_4 AND :DTAFIN_4, DET_QTDITE, 0 ) ) AS QTDITE_MES_4, ';
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_4 AND :DTAFIN_4, (DET_TOTITE - DET_DESESP - DET_DESCFF), 0 ) ) AS VLRITE_MES_4, ';
    End
    Else
    Begin
      Result := Result + ' 0 AS QTDITE_MES_4, ';
      Result := Result + ' 0 AS VLRITE_MES_4, ';
    End;

    If FPeriodoAnalise.dteDtaIni_5 > 0 Then
    Begin
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_5 AND :DTAFIN_5, DET_QTDITE, 0 ) ) AS QTDITE_MES_5, ';
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_5 AND :DTAFIN_5, (DET_TOTITE - DET_DESESP - DET_DESCFF), 0 ) ) AS VLRITE_MES_5, ';
    End
    Else
    Begin
      Result := Result + ' 0 AS QTDITE_MES_5, ';
      Result := Result + ' 0 AS VLRITE_MES_5, ';
    End;

    If FPeriodoAnalise.dteDtaIni_6 > 0 Then
    Begin
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_6 AND :DTAFIN_6, DET_QTDITE, 0 ) ) AS QTDITE_MES_6, ';
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_6 AND :DTAFIN_6, (DET_TOTITE - DET_DESESP - DET_DESCFF), 0 ) ) AS VLRITE_MES_6, ';
    End
    Else
    Begin
      Result := Result + ' 0 AS QTDITE_MES_6, ';
      Result := Result + ' 0 AS VLRITE_MES_6, ';
    End;

    If FPeriodoAnalise.dteDtaIni_7 > 0 Then
    Begin
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_7 AND :DTAFIN_7, DET_QTDITE, 0 ) ) AS QTDITE_MES_7, ';
      Result := Result + '  SUM( IF( GER_DTAENT BETWEEN :DTAINI_7 AND :DTAFIN_7, (DET_TOTITE - DET_DESESP - DET_DESCFF), 0 ) ) AS VLRITE_MES_7  ';
    End
    Else
    Begin
      Result := Result + ' 0 AS QTDITE_MES_7, ';
      Result := Result + ' 0 AS VLRITE_MES_7 ';
    End;

    Result := Result + ' FROM (';
  end;

begin
  If (blnVenda6Meses) Then
    strSQL := ' SELECT DISTINCT MOVDET.DET_CODITE AS CODITE '
  Else
  Begin
    strSQL := ' SELECT MOVDET.DET_CODITE, ';
    strSQL := strSQL + '  MOVDET.DET_DESCRI, ';
    strSQL := strSQL + '  MOVDET.DET_TOTCUS, ';
    strSQL := strSQL + '  MOVDET.DET_TOTMED, ';
    strSQL := strSQL + '  MOVTRI.DET_TAXJUR, ';
    strSQL := strSQL + '  MOVTRI.DET_OUTVAL, ';
    strSQL := strSQL + '  MOVTRI.DET_TAXENT, ';
    strSQL := strSQL + '  MOVDET.DET_DESESP, ';
    strSQL := strSQL + '  MOVDET.DET_QTDITE, ';
    strSQL := strSQL + '  MOVTRI.DET_ICMSAI, ';
    strSQL := strSQL + '  MOVTRI.DET_IMPFED, ';
    strSQL := strSQL + '  MOVTRI.DET_DESOPE, ';
    strSQL := strSQL + '  MOVDET.DET_TOTITE, ';
    strSQL := strSQL + '  MOVDET.DET_DESCFF, ';
    strSQL := strSQL + '  MOVGER.GER_DTAENT, ';
    strSQL := strSQL + '  MOVGER.GER_HORENT  ';
  End;

  strSQL := strSQL + ' FROM MOVGER ';
  strSQL := strSQL + ' INNER JOIN MOVDET ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
  strSQL := strSQL + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = MOVDET.DET_CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = MOVDET.DET_CODITE ';
  strSQL := strSQL + '                  AND ITEGER.ITE_CODEMP = MOVDET.DET_CODEMP ';
  strSQL := strSQL + ' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';

  strSQL := strSQL + ' WHERE DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND';

  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  ITE_CLACRM = "C" AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C"  AND ';
  strSQL := strSQL + '  DET_IDEPRO = "NOR"  AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S"  AND ';
  strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

  If fCfgSis('ENTBRF', varBoolean) Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    strSQL := strSQL + ') ';

  If (Not blnVenda6Meses) Then
    strSQL := strSQL + ' AND DET_CODITE = :CODITE ';

  strSQL := strSQL + fStrLocate(FEdtCodMar, arrMarca,  'CADITE.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(FEdtCodFor, arrFornec, 'CADITE.ITE_CODFOR', 'CODFOR');
  strSQL := strSQL + fStrLocate(FEdtLinGru, arrLinGru, 'CADITE.ITE_CODGRU', 'CODGRU');
  strSQL := strSQL + fStrLocate(FEdtCadGru, arrCadGru, 'CADITE.ITE_PRDGRU', 'PRDGRU');
  strSQL := strSQL + fStrLocate(FEdtCodDep, arrDepart, 'CADITE.ITE_CODDEP', 'CODDEP');

  Result := strSQL;

  If (not blnVenda6Meses) Then
    Result := fGetSelectGroup + Result + ') AS TMP GROUP BY DET_CODITE ';
end;

function TImpulsionadorVendasCRM.fGetSQLProdutosOrcPed: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CI.ITE_CODITE AS CODITE, ';
  Result := Result + '   CI.ITE_DESITE AS DESCRI, ';
  Result := Result + '   UN.UNI_SIGUNI AS UNIDAD, ';
  Result := Result + '   ULTVND.DTAUVE,           ';
  Result := Result + '   ULTVND.QTDUVE,           ';
  Result := Result + '   ULTVND.PREUVE,           ';
  Result := Result + '   ULTVND.NUMDOC,           ';
  Result := Result + '   0.0000        AS MARGEM, ';
  Result := Result + '   VENDAS.QTDORC AS QTDORC, ';
  Result := Result + '   VENDAS.TOTORC AS TOTORC, ';
  Result := Result + '   VENDAS.QTDPED AS QTDPED, ';
  Result := Result + '   VENDAS.TOTPED AS TOTPED, ';
  Result := Result + '   CI.ITE_NVLGIR AS NVLGIR  ';

  Result := Result + ' FROM ';
  Result := Result + '   CADITE CI ';
  Result := Result + '   INNER JOIN ITEGER IG ';
  Result := Result + '     ON IG.ITE_CODITE = CI.ITE_CODITE ';
  Result := Result + '     AND IG.ITE_CODEMP = :CODEMP ';
  Result := Result + '   INNER JOIN CADUNI UN ';
  Result := Result + '     ON UN.UNI_CODUNI = CI.ITE_CODUNI ';
  Result := Result + '   LEFT JOIN ';
  Result := Result + '     (SELECT ';
  Result := Result + '       FD.FDO_CODITE AS CODITE, ';
  Result := Result + '       FD.FDO_CODEMP AS CODEMP, ';
  Result := Result + '       SUM(IF(FG.FGO_ESPDOC = "OR", FD.FDO_QTDITE, 0)) AS QTDORC, ';
  Result := Result + '       SUM(IF(FG.FGO_ESPDOC = "OR", FD.FDO_TOTITE, 0)) AS TOTORC, ';
  Result := Result + '       SUM(IF(FG.FGO_ESPDOC = "PD", FD.FDO_QTDITE, 0)) AS QTDPED, ';
  Result := Result + '       SUM(IF(FG.FGO_ESPDOC = "PD", FD.FDO_TOTITE, 0)) AS TOTPED ';
  Result := Result + '     FROM ';
  Result := Result + '       FATGOR FG ';
  Result := Result + '       INNER JOIN FATDOR FD ';
  Result := Result + '         ON FG.AUTOINCREM = FD.FDO_SEQGER ';
  Result := Result + '     WHERE FGO_CODCLI = :CODCLI ';
  Result := Result + '       AND FGO_CODEMP = :CODEMP ';
  Result := Result + '       AND ( ';
  Result := Result + '         (FGO_ESPDOC = "OR") ';
  Result := Result + '         OR (FGO_ESPDOC = "PD") ';
  Result := Result + '       ) ';
  Result := Result + '       AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  Result := Result + '       AND FGO_JAFATU = FALSE ';
  Result := Result + '     GROUP BY FD.FDO_CODITE) AS VENDAS ';
  Result := Result + '     ON VENDAS.CODITE = CI.ITE_CODITE ';
  Result := Result + '     AND VENDAS.CODEMP = IG.ITE_CODEMP ';

  Result := Result + '   LEFT JOIN ';
  Result := Result + '    (SELECT ';
  Result := Result + '       CONCAT(G.GER_NUMDOC,"-",G.GER_ESPDOC) AS NUMDOC, ';
  Result := Result + '       D.DET_DTAENT AS DTAUVE, ';
  Result := Result + '       D.DET_UNITAR AS PREUVE, ';
  Result := Result + '       D.DET_HORENT AS HORUVE, ';
  Result := Result + '       SUM(D.DET_QTDITE) AS QTDUVE, ';
  Result := Result + '       D.DET_CODITE ';
  Result := Result + '      FROM ';
  Result := Result + '       MOVGER G ';
  Result := Result + '      JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
  Result := Result + '     WHERE LOCATE(G.GER_CLAFIS, :CLAVEN) > 0 ';
  Result := Result + '       AND LEFT(G.GER_CLAFIS, 1) >= 5 ';
  Result := Result + '       AND G.GER_CODCLI = :CODCLI ';
  Result := Result + '       AND D.DET_CODITE = :CODITE ';
  Result := Result + '       AND D.DET_CODEMP = :CODEMP ';
  Result := Result + '       AND D.DET_ESPDOC NOT IN ("TR") ';
  Result := Result + '       AND D.DET_ESPDOC NOT IN ("DV") ';
  Result := Result + '     GROUP BY D.DET_CODITE, CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC), D.DET_DTAENT, D.DET_HORENT, D.DET_UNITAR ';
  Result := Result + '     ORDER BY G.GER_DTAENT DESC, G.GER_HORENT DESC ';
  Result := Result + '     LIMIT 1) AS ULTVND ON ULTVND.DET_CODITE = CI.ITE_CODITE ';

  Result := Result + ' WHERE IG.ITE_CODEMP = :CODEMP ';
  Result := Result + '   AND CI.ITE_CLACRM = "C" ';
  Result := Result + '   AND CI.ITE_CODITE = :CODITE ';
  Result := Result + '   AND IFNULL(ULTVND.NUMDOC, "") <> "" ';
end;

function TImpulsionadorVendasCRM.fGetTabPre: String;
begin
  Result := FTabPre;
end;

function TImpulsionadorVendasCRM.fPossuiItensGerarOrcamento: Boolean;
begin
  Result := False;
  FintQtdItensGerarOR := 0;
  Try
    FCdsVendas.DisableControls();
    FCdsVendas.First();

    Try
      While (Not FCdsVendas.Eof) Do
      Begin
        If (FCdsVendas.FieldByName('SELECT').AsInteger = 1) And (FCdsVendas.FieldByName('INSORC').AsString = 'N') Then
        Begin
          Inc(FintQtdItensGerarOR);
        End;

        FCdsVendas.Next();
      End;

      Result := FintQtdItensGerarOR > 0;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.fRealizarOrcamento]');
    End;
  Finally
    FCdsVendas.EnableControls();
  End;
end;

function TImpulsionadorVendasCRM.fRealizarOrcamento: Boolean;
begin
  Result := False;

  Try
    pCriarFormularios(TfrmFatVendas, frmFatVendas);

    If Not frmFatVendas.blnFecharForm Then
    Begin
      frmFatVendas.strOpcDoc       := 'OR';
      frmFatVendas.strTitulo       := 'Orçamento';
      frmFatVendas.blnApenasPrazo  := False;
      frmFatVendas.blnApenasVista  := False;
      frmFatVendas.blnDevBaiEntFut := False;
      frmFatVendas.blnConEqu       := False;
      frmFatVendas.strCodCliDef    := FCodCli;
      frmFatVendas.edtCodCli.Text  := FCodCli;
      frmFatVendas.objImpulsionadorVendasCRM := Self;

      FIncluiuProdutosOrc := False;

      frmFatVendas.ShowModal();

      Result := frmFatVendas.blnConfirma;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.fRealizarOrcamento]');
  End;

  pFreeAndNil(frmFatVendas);
  Application.ProcessMessages;
end;

function TImpulsionadorVendasCRM.fRetPrecoVenda(strCodIte: String): Double;
begin
  Result := fCampoTabela('ITE_PREVE' + FTabPre, 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
end;

function TImpulsionadorVendasCRM.fRetTabPre(strCodCli: String): String;
begin
  Result := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  If (fEmptyStr(Result)) Then Result := '1';
end;

function TImpulsionadorVendasCRM.fValidarFiltroData(AMskDtaIni,
  AMskDtaFin: TMaskEditFocus): Boolean;
var
  diaAtual, mesAtual, anoAtual: Word;
  anoInicial, mesInicial, diaInicial: Word;
begin
  Result := False;

  FDtaIniAnalise := StrToDateTime(FMskDtaIni.Text);
  FDtaFinAnalise := StrToDateTime(FMskDtaFin.Text);

  DecodeDate(FDtaIniAnalise, anoInicial, mesInicial, diaInicial);
  DecodeDate(FDtaFinAnalise , anoAtual, mesAtual, diaAtual);

  FIntNroMeses := IIF(anoInicial < anoAtual, (12 - mesInicial) + mesAtual, mesAtual - mesInicial);
  If FIntNroMeses <= 6 Then
  Begin
    FMskDtaIni := AMskDtaIni;
    FMskDtaFin := AMskDtaFin;
    Result := True;
  End;
end;

procedure TImpulsionadorVendasCRM.pSetCodCli(Value: String);
begin
  FCodCli := Value;
end;

procedure TImpulsionadorVendasCRM.pCriarClientDataSet;
begin
  Try
    FCdsVendas := TUniClientDataSet.Create(nil);

    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString;   Size := fTamCodIte; Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'DESCRI'; DataType := ftString;   Size := 256; Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'UNIDAD'; DataType := ftString;   Size := 002; Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'DTAUVE'; DataType := ftDateTime;              Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDUVE'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'PREUVE'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'UNITAR'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'TOTITE'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'MARGEM'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDORC'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'TOTORC'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDPED'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'TOTPED'; DataType := ftFloat;                 Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'SELECT'; DataType := ftInteger;               Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'NVLGIR'; DataType := ftString;  Size := 001;  Required := False; End;

    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE_MES_1'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'VLRITE_MES_1'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE_MES_2'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'VLRITE_MES_2'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE_MES_3'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'VLRITE_MES_3'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE_MES_4'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'VLRITE_MES_4'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE_MES_5'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'VLRITE_MES_5'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE_MES_6'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'VLRITE_MES_6'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'QTDITE_MES_7'; DataType := ftFloat;           Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'VLRITE_MES_7'; DataType := ftFloat;           Required := False; End;

    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'NUMDOC'; DataType := ftString;   Size := 255; Required := False; End;
    With FCdsVendas.FieldDefs.AddFieldDef Do Begin Name := 'INSORC'; DataType := ftString;  Size := 001;  Required := False; End;


    FCdsVendas.CreateDataSet();
    FCdsVendas.Open();

    TFloatField(FCdsVendas.FieldByName('QTDUVE')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('PREUVE')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('UNITAR')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('TOTITE')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('MARGEM')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDORC')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('TOTORC')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDPED')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('TOTPED')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE_MES_1')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('VLRITE_MES_1')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE_MES_2')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('VLRITE_MES_2')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE_MES_3')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('VLRITE_MES_3')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE_MES_4')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('VLRITE_MES_4')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE_MES_5')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('VLRITE_MES_5')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE_MES_6')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('VLRITE_MES_6')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('QTDITE_MES_7')).DisplayFormat := '#,##0.00';
    TFloatField(FCdsVendas.FieldByName('VLRITE_MES_7')).DisplayFormat := '#,##0.00';

    FCdsVendas.AfterScroll := FAterScrollResumoVendas;
    FCdsVendas.BeforePost  := FBeforePostResumoVendas;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.pCriarClientDataSet]');
  End;
end;

procedure TImpulsionadorVendasCRM.pDefinirParametrosQuery(qryDados: TUniQuery; strCodIte: String; dteDataIni, dteDataFin: TDateTime);
begin
  Try
    If (Assigned(qryDados)) Then
    Begin
      If (qryDados.FindParam('DTAINI') <> nil) Then qryDados.ParamByName('DTAINI').AsDateTime := dteDataIni;
      If (qryDados.FindParam('DTAFIN') <> nil) Then qryDados.ParamByName('DTAFIN').AsDateTime := dteDataFin;

      If (qryDados.FindParam('CODCLI') <> nil) Then qryDados.ParamByName('CODCLI').AsString := FCodCli;

      If (qryDados.FindParam('CODITE') <> nil) Then qryDados.ParamByName('CODITE').AsString := strCodIte;
      If (qryDados.FindParam('CODEMP') <> nil) Then qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      If (qryDados.FindParam('CLAVEN') <> nil) Then qryDados.ParamByName('CLAVEN').AsString := VS_strClaVen;
      If (qryDados.FindParam('CLADEV') <> nil) Then qryDados.ParamByName('CLADEV').AsString := VS_strClaDev;

      If (qryDados.FindParam('CODMAR') <> nil) Then pSetaParam(FEdtCodMar.Text, arrMarca , FMarca ,   'CODMAR', qryDados);
      If (qryDados.FindParam('CODFOR') <> nil) Then pSetaParam(FEdtCodFor.Text, arrFornec, FFornec,   'CODFOR', qryDados);
      If (qryDados.FindParam('CODGRU') <> nil) Then pSetaParam(FEdtLinGru.Text, arrLinGru, FLinGrupo, 'CODGRU', qryDados);
      If (qryDados.FindParam('PRDGRU') <> nil) Then pSetaParam(FEdtCadGru.Text, arrCadGru, FGruProd,  'PRDGRU', qryDados);
      If (qryDados.FindParam('CODDEP') <> nil) Then pSetaParam(FEdtCodDep.Text, arrDepart, FCodDep,   'CODDEP', qryDados);

      If (qryDados.FindParam('DTAINI_1') <> nil) Then qryDados.ParamByName('DTAINI_1').AsDateTime := FPeriodoAnalise.dteDtaIni_1;
      If (qryDados.FindParam('DTAFIN_1') <> nil) Then qryDados.ParamByName('DTAFIN_1').AsDateTime := FPeriodoAnalise.dteDtaFin_1;
      If (qryDados.FindParam('DTAINI_2') <> nil) Then qryDados.ParamByName('DTAINI_2').AsDateTime := FPeriodoAnalise.dteDtaIni_2;
      If (qryDados.FindParam('DTAFIN_2') <> nil) Then qryDados.ParamByName('DTAFIN_2').AsDateTime := FPeriodoAnalise.dteDtaFin_2;
      If (qryDados.FindParam('DTAINI_3') <> nil) Then qryDados.ParamByName('DTAINI_3').AsDateTime := FPeriodoAnalise.dteDtaIni_3;
      If (qryDados.FindParam('DTAFIN_3') <> nil) Then qryDados.ParamByName('DTAFIN_3').AsDateTime := FPeriodoAnalise.dteDtaFin_3;
      If (qryDados.FindParam('DTAINI_4') <> nil) Then qryDados.ParamByName('DTAINI_4').AsDateTime := FPeriodoAnalise.dteDtaIni_4;
      If (qryDados.FindParam('DTAFIN_4') <> nil) Then qryDados.ParamByName('DTAFIN_4').AsDateTime := FPeriodoAnalise.dteDtaFin_4;
      If (qryDados.FindParam('DTAINI_5') <> nil) Then qryDados.ParamByName('DTAINI_5').AsDateTime := FPeriodoAnalise.dteDtaIni_5;
      If (qryDados.FindParam('DTAFIN_5') <> nil) Then qryDados.ParamByName('DTAFIN_5').AsDateTime := FPeriodoAnalise.dteDtaFin_5;
      If (qryDados.FindParam('DTAINI_6') <> nil) Then qryDados.ParamByName('DTAINI_6').AsDateTime := FPeriodoAnalise.dteDtaIni_6;
      If (qryDados.FindParam('DTAFIN_6') <> nil) Then qryDados.ParamByName('DTAFIN_6').AsDateTime := FPeriodoAnalise.dteDtaFin_6;
      If (qryDados.FindParam('DTAINI_7') <> nil) Then qryDados.ParamByName('DTAINI_7').AsDateTime := FPeriodoAnalise.dteDtaIni_7;
      If (qryDados.FindParam('DTAFIN_7') <> nil) Then qryDados.ParamByName('DTAFIN_7').AsDateTime := FPeriodoAnalise.dteDtaFin_7;

      qryDados.Open();
      qryDados.First();
    End;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.pDefinirParametrosQuery]');
  End;
end;

function TImpulsionadorVendasCRM.fRetDataInicialPeriodo(const dtaReferencia: TDateTime;
  intQtdMeses: Integer = 0): TDateTime;
var
  dia, mes, ano: Word;
  dtaAux: TDateTime;
begin
  If intQtdMeses > 0 Then
    dtaAux := IncMonth(dtaReferencia, -intQtdMeses)
  Else
    dtaAux := dtaReferencia;

  DecodeDate(dtaAux, ano, mes, dia);
  Result :=  EncodeDate(ano, mes, 1);
end;

function TImpulsionadorVendasCRM.fRetDataFinalPeriodo(const dtaReferencia: TDateTime;
  intQtdMeses: Integer = 0): TDateTime;
var
  dia, mes, ano: Word;
  dtaAux: TDateTime;
begin
  If intQtdMeses > 0 Then
    dtaAux := IncMonth(dtaReferencia, -intQtdMeses)
  Else
    dtaAux := dtaReferencia;

  DecodeDate(dtaAux, ano, mes, dia);
  dtaAux := EndOfAMonth(ano, mes);
  Result := IIF(dtaAux <= FDtaFinAnalise, dtaAux, FDtaFinAnalise);
end;

function TImpulsionadorVendasCRM.fRetDescricaoMes(const aData: TDateTime): String;
var
  dia, mes, ano: Word;
begin
  DecodeDate(aData, ano, mes, dia);

  Result := '   ' + FormatFloat('00', mes) + '/' + IntToStr(ano) + '   ';
end;

function TImpulsionadorVendasCRM.fRetNroMesesAnalise: Integer;
var
  dtaIniTmpAux,
  dtaFimTmpAux: TDateTime;
  blnAnalisaMesParcial: Boolean;
begin
  dtaIniTmpAux := fRetDataInicialPeriodo(FDtaIniAnalise);
  dtaFimTmpAux := fRetDataFinalPeriodo(FDtaFinAnalise);
  blnAnalisaMesParcial := Not ((dtaIniTmpAux = FDtaIniAnalise) and (dtaFimTmpAux = EndOfTheMonth(FDtaFinAnalise)));

  Result := IIF(blnAnalisaMesParcial, FIntNroMeses+1, FIntNroMeses);
end;

procedure TImpulsionadorVendasCRM.pDefinirPeriodoAnaliseVendas;
Var
  intCnt: Integer;
  dtaIniAnaliseTmp,
  dtaIniMesAnalise: TDateTime;
  intNroMesesAna,
  intNroMesesCalc: Integer;
  blnPenultimoMesAna,
  blnUltimoMesAna: Boolean;
  dtaIniMesTmp,
  dtaFimMesTmp: TDateTime;

begin
  Try
    FPeriodoAnalise.strDescMes7 := '';
    FPeriodoAnalise.strDescMes6 := '';
    FPeriodoAnalise.strDescMes5 := '';
    FPeriodoAnalise.strDescMes4 := '';
    FPeriodoAnalise.strDescMes3 := '';
    FPeriodoAnalise.strDescMes2 := '';
    FPeriodoAnalise.strDescMes1 := '';

    dtaIniAnaliseTmp:= FDtaIniAnalise;
    intNroMesesAna  := fRetNroMesesAnalise;
    intNroMesesCalc := 0;

    For intCnt :=  7 DownTo 1 Do
    Begin
      blnPenultimoMesAna := (intCnt = FIntNroMeses);
      blnUltimoMesAna    := (intCnt = intNroMesesAna);
      dtaIniMesAnalise   := fRetDataInicialPeriodo(FDtaFinAnalise, intNroMesesCalc);

      If (intCnt <= intNroMesesAna) Then
      Begin

        dtaIniMesTmp := dtaIniMesAnalise;
        dtaFimMesTmp := fRetDataFinalPeriodo(FDtaFinAnalise, intNroMesesCalc);
        dtaIniAnaliseTmp := dtaIniMesTmp;

        If blnPenultimoMesAna Then
          FDtaPenultimoMesAna := dtaFimMesTmp;

        If blnUltimoMesAna Then
        Begin
          FDtaIniUltimoMesAna := dtaIniMesTmp;
          FDtaFimUltimoMesAna := dtaFimMesTmp;
        End;

        Case intCnt Of
          7: Begin
               FPeriodoAnalise.strDescMes7 := fRetDescricaoMes(dtaIniMesTmp);
               FPeriodoAnalise.dteDtaIni_7 := dtaIniMesTmp;
               FPeriodoAnalise.dteDtaFin_7 := dtaFimMesTmp;
             End;
          6: Begin
               FPeriodoAnalise.strDescMes6 := fRetDescricaoMes(dtaIniMesTmp);
               FPeriodoAnalise.dteDtaIni_6 := dtaIniMesTmp;
               FPeriodoAnalise.dteDtaFin_6 := dtaFimMesTmp;
             End;
          5: Begin
               FPeriodoAnalise.strDescMes5 := fRetDescricaoMes(dtaIniMesTmp);
               FPeriodoAnalise.dteDtaIni_5 := dtaIniMesTmp;
               FPeriodoAnalise.dteDtaFin_5 := dtaFimMesTmp;
             End;
          4: Begin
               FPeriodoAnalise.strDescMes4 := fRetDescricaoMes(dtaIniMesTmp);
               FPeriodoAnalise.dteDtaIni_4 := dtaIniMesTmp;
               FPeriodoAnalise.dteDtaFin_4 := dtaFimMesTmp;
             End;
          3: Begin
               FPeriodoAnalise.strDescMes3 := fRetDescricaoMes(dtaIniMesTmp);
               FPeriodoAnalise.dteDtaIni_3 := dtaIniMesTmp;
               FPeriodoAnalise.dteDtaFin_3 := dtaFimMesTmp;
             End;
          2: Begin
               FPeriodoAnalise.strDescMes2 := fRetDescricaoMes(dtaIniMesTmp);
               FPeriodoAnalise.dteDtaIni_2 := dtaIniMesTmp;
               FPeriodoAnalise.dteDtaFin_2 := dtaFimMesTmp;
             End;
          1: Begin
               FPeriodoAnalise.strDescMes1 := fRetDescricaoMes(dtaIniMesTmp);
               dtaIniAnaliseTmp := IIF(dtaIniMesTmp <> FDtaIniAnalise, FDtaIniAnalise, dtaIniMesTmp);
               FPeriodoAnalise.dteDtaIni_1 := dtaIniAnaliseTmp;
               FPeriodoAnalise.dteDtaFin_1 := dtaFimMesTmp;
             End;
        End;

        Inc(intNroMesesCalc);
      End;

    End;

    FDtaIniAnalise := dtaIniAnaliseTmp;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TImpulsionadorVendasCRM.pDefinirPeriodoAnaliseVendas]');
  End;
end;

procedure TImpulsionadorVendasCRM.pInicializarComponentes;
begin
  pCriarClientDataSet();
end;

procedure TImpulsionadorVendasCRM.pLimparArraysConsulta;
begin
  SetLength(Self.arrFornec, 0);
  SetLength(Self.arrMarca,  0);
  SetLength(Self.arrLinGru, 0);
  SetLength(Self.arrCadGru, 0);
end;

procedure TImpulsionadorVendasCRM.pLimparClientDataSet;
begin
  FCdsVendas.EmptyDataSet();
end;

procedure TImpulsionadorVendasCRM.pLimparFiltros;
begin
  pLimparArraysConsulta();
end;

end.
