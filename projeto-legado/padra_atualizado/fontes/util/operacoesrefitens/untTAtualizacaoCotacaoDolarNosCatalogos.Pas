unit untTAtualizacaoCotacaoDolarNosCatalogos;

interface

uses Forms, Uni, untFuncoesSimples, untTypesSistema, Classes, SysUtils,
     untFuncoesConsulta, Data.DB, untParCalculaPrecoCusto, untZClient,
     Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls, DateUtils, cxProgressBar,
     Vcl.Graphics;


  Type
    TSituacao = (stAtivo, stInativo, stTodos);
    TCalculo = (tcPrecoVenda, tcPrecoMargem);

    TAtualizacaoCotacaoDolarNosCatalogos = class
    private
      FQry: TZClient;
      qryGrava: TUniQuery;
      FValorDolar: Double;
      strEstEmp: String;
      strMarMkp: String;
      strPcmPro: String;
      intDecUni: Integer;
      cpcParams: TParCalculaPrecoCusto;
      FTipoCalculo: TCalculo;

      HorIni: TTime;
      ValidacoesPorSegundo,
      intQtdProcess :integer;
      qtdSegundos: Double;
      TempoExtimado: String;
      ultimaValidacao: TTime;

      dtaDtaAltera : TDate;
      blnAgendado  : Boolean;
      function fGetValorDolar: Double;
      function fRetPrecoCusto: Double;
      function fTrataTextoTempo(segundos: Integer): String;
      procedure pCalculaTempo(blnGravacao: Boolean);
      Function fConfirmaData: Boolean;
      procedure pAtualizavaloresCatalogo;
      procedure pIncluiPreIteCatalogo(qryGenIte: TUniQuery; qryGenGlo: TDataSet; dtaDtaAlt: TDate; strNomFrm, strProPri: String; blnPreDol: Boolean = False);
      function  fGravaProdutos(pgbProgresso: TcxProgressBar): Boolean;
      function  fCalculaPrecoMargem(pgbProgresso: TcxProgressBar): Boolean;
    public
      arrLinFor,
      arrLinMar,
      arrLinUni: TConsultasArray;
      strLinMar,
      strLinFor,
      strLinUni: String;
      Fprogress: TcxProgressBar;
      FCaption: TLabel;
      Constructor Create();
      Destructor Destroy;Override;
      function fCarregar(strCodFor, strCodmar, strCodUni: string; Situacao: TSituacao): Boolean;
      function fCalcular(TipoCalculo: TCalculo): Boolean;
      procedure pChamaTelaConfirmarCalculo;
      property ValorDolar: Double read fGetValorDolar;
      procedure pGravar;

  End;
implementation

uses
  untIcmsSTParteVenda, untTConfiguracao,
  untAtualizacaoCotacaoDolarNosCatalogosConfirma, untAltPrecoDigData,
  untAltEfetivacaoPrecos, untGravando;

{ TAtualizacaoCotacaoDolarNosCatalogos }

procedure TAtualizacaoCotacaoDolarNosCatalogos.pChamaTelaConfirmarCalculo;
begin
  pCriarFormularios(TfrmAtualizacaoCotacaoDolarNosCatalogosConfirma, frmAtualizacaoCotacaoDolarNosCatalogosConfirma);
  Try
    frmAtualizacaoCotacaoDolarNosCatalogosConfirma.dtsItens.DataSet := FQry;
    frmAtualizacaoCotacaoDolarNosCatalogosConfirma.TipoCalculo := FTipoCalculo;
    frmAtualizacaoCotacaoDolarNosCatalogosConfirma.ObjAtualizacao := Self;
    frmAtualizacaoCotacaoDolarNosCatalogosConfirma.ShowModal;
  Finally
    FreeAndNil(frmAtualizacaoCotacaoDolarNosCatalogosConfirma);
  End;

end;


Function TAtualizacaoCotacaoDolarNosCatalogos.fConfirmaData: Boolean;
var strMensagem: String;
Begin

  FQry.Filtered := False;
  FQry.Filter := 'CAT_CODITE <> ' + QuotedStr('');
  FQry.Filtered := True;
  blnAgendado := False;

  Result := FQry.IsEmpty;
  pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);
  Try
    If Not Result Then
    Begin
      frmAltPrecoDigData.Showmodal;
      If frmAltPrecoDigData.blnConfirma Then
      Begin
        If (frmAltPrecoDigData.dtaData = VS_Date) Then
          strMensagem := 'Os preços serão agendados para hoje. Confirma?'
        Else
          strMensagem := 'Os preços serão alterados no dia '+ DateToStr(frmAltPrecoDigData.dtaData) + '. Confirma?';
        Result := fMensagem('Confirmação' ,strMensagem, ['&Sim','&Não']) = 1;
        blnAgendado := Result;
      End;
    End;

    dtaDtaAltera := frmAltPrecoDigData.dtaData;

  Finally
    FreeAndNil(frmAltPrecoDigData);
  End;
  FQry.Filtered := False;
  FQry.Filter := '';

End;

procedure TAtualizacaoCotacaoDolarNosCatalogos.pAtualizavaloresCatalogo;
begin
  qryGrava.SQL.Clear;
  qryGrava.SQL.Add('UPDATE CATITE SET');
  qryGrava.SQL.Add('     CAT_PRECUS = :PRECUS,');
  qryGrava.SQL.Add('     CAT_PREVE1 = :PREVE1,');
  qryGrava.SQL.Add('     CAT_MARBR1 = :MARBR1,');
  qryGrava.SQL.Add('     CAT_PREVE2 = :PREVE2,');
  qryGrava.SQL.Add('     CAT_MARBR2 = :MARBR2,');
  qryGrava.SQL.Add('     CAT_PREVE3 = :PREVE3,');
  qryGrava.SQL.Add('     CAT_MARBR3 = :MARBR3,');
  qryGrava.SQL.Add('     CAT_PREVE4 = :PREVE4,');
  qryGrava.SQL.Add('     CAT_MARBR4 = :MARBR4,');
  qryGrava.SQL.Add('     CAT_PREVE5 = :PREVE5,');
  qryGrava.SQL.Add('     CAT_MARBR5 = :MARBR5,');
  qryGrava.SQL.Add('     CAT_PREVE6 = :PREVE6,');
  qryGrava.SQL.Add('     CAT_MARBR6 = :MARBR6,');
  qryGrava.SQL.Add('     CAT_PREVE7 = :PREVE7,');
  qryGrava.SQL.Add('     CAT_MARBR7 = :MARBR7');
  qryGrava.SQL.Add('  WHERE CAT_CODFAB = :CODFAB');
  qryGrava.SQL.Add('    AND CAT_CODFOR = :CODFOR');
  qryGrava.ParamByName('PRECUS').Value := FQry.FieldByName('CAT_PRECUS_NOV').Value;
  qryGrava.ParamByName('PREVE1').Value := FQry.FieldByName('CAT_PREVE1_NOV').Value;
  qryGrava.ParamByName('MARBR1').Value := FQry.FieldByName('CAT_MARBR1_NOV').Value;
  qryGrava.ParamByName('PREVE2').Value := FQry.FieldByName('CAT_PREVE2_NOV').Value;
  qryGrava.ParamByName('MARBR2').Value := FQry.FieldByName('CAT_MARBR2_NOV').Value;
  qryGrava.ParamByName('PREVE3').Value := FQry.FieldByName('CAT_PREVE3_NOV').Value;
  qryGrava.ParamByName('MARBR3').Value := FQry.FieldByName('CAT_MARBR3_NOV').Value;
  qryGrava.ParamByName('PREVE4').Value := FQry.FieldByName('CAT_PREVE4_NOV').Value;
  qryGrava.ParamByName('MARBR4').Value := FQry.FieldByName('CAT_MARBR4_NOV').Value;
  qryGrava.ParamByName('PREVE5').Value := FQry.FieldByName('CAT_PREVE5_NOV').Value;
  qryGrava.ParamByName('MARBR5').Value := FQry.FieldByName('CAT_MARBR5_NOV').Value;
  qryGrava.ParamByName('PREVE6').Value := FQry.FieldByName('CAT_PREVE6_NOV').Value;
  qryGrava.ParamByName('MARBR6').Value := FQry.FieldByName('CAT_MARBR6_NOV').Value;
  qryGrava.ParamByName('PREVE7').Value := FQry.FieldByName('CAT_PREVE7_NOV').Value;
  qryGrava.ParamByName('MARBR7').Value := FQry.FieldByName('CAT_MARBR7_NOV').Value;
  qryGrava.ParamByName('CODFAB').Value := FQry.FieldByName('CODFAB').Value;
  qryGrava.ParamByName('CODFOR').Value := FQry.FieldByName('CAT_CODFOR').Value;
  qryGrava.ExecSQL;
end;

function TAtualizacaoCotacaoDolarNosCatalogos.fGravaProdutos(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  FQry.First;
  FProgress := pgbProgresso;
  Fprogress.Properties.Max := FQry.RecordCount;
  Fprogress.Position := 0;
  HorIni := fNow;
  qtdSegundos := 0;
  ValidacoesPorSegundo := 0;
  intQtdProcess := 0;
  TempoExtimado := '';
  ultimaValidacao := 0;
  Result := True;
  fStartTransaction();
  Try
    while not FQry.Eof do
    Begin
      pAtualizavaloresCatalogo;
      If FQry.FieldByName('CAT_CODITE').AsString <> '' Then
        pIncluiPreIteCatalogo(qryGrava, FQry, dtaDtaAltera, 'TfrmImportCadProdutoConfirma', fRetSequencial('PROPRI', VS_strCodEmp));

      FQry.Next;
      Inc(intQtdProcess);
      pCalculaTempo(True);
    End;

    fCommit;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollback;
    End;
  End;

end;


procedure TAtualizacaoCotacaoDolarNosCatalogos.pGravar;
  Var blnErro: Boolean;
begin
  blnErro := False;
  FQry.DisableControls;
  Try

    If fConfirmaData then
    Begin
      FQry.First;
      Application.ProcessMessages;

      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        Try
          frmGravando.lblGravando.Caption := 'Aguarde...Processando Itens.';
          frmGravando.fExecutarAcao := fGravaProdutos;
          FCaption             := TLabel.create(application);
          FCaption.Parent      := frmGravando;
          FCaption.Name        := 'lblContador';
          FCaption.Left        := 10;
          FCaption.Top         := 110;
          FCaption.Font.Height := 14;
          FCaption.Font.Name   := 'Arial';
          FCaption.Font.Pitch  := fpVariable;
          FCaption.Font.Style  := [fsBold];
          FCaption.Caption     := '';
          frmGravando.ShowModal
        Finally
          FreeAndNil(frmGravando);
        End;
      Except
        On e: Exception do
        begin
          blnErro := True;
          pMensagensErro(E.Message,'[TAtualizacaoCotacaoDolarNosCatalogos.pGravar]');
        End;
      End;
    End;

    If Not blnErro Then
    begin
      If (dtaDtaAltera = DateOf(fNow)) And (blnAgendado) Then
      Begin
        pCriarFormularios(TfrmAltEfetivacaoPrecos, frmAltEfetivacaoPrecos);
        Try
          frmAltEfetivacaoPrecos.Showmodal;
          fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);
        Finally
          pFreeAndNil(frmAltEfetivacaoPrecos);
        End;
      End
      Else
        fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);
    End;
  Finally
    FQry.EnableControls;
  End;

end;

constructor TAtualizacaoCotacaoDolarNosCatalogos.Create();
begin
  qryGrava := fCriaQuery(Nil);
  FQry := TZClient.Create(Nil);
  strEstEmp := fCadEmp('ESTADO');
  intDecUni := fCfgSis('DECUNI', varInteger);
  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');
  cpcParams := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao, True, True);
end;

destructor TAtualizacaoCotacaoDolarNosCatalogos.Destroy;
begin
  FreeAndNil(FQry);
  FreeAndNil(cpcParams);
  FreeAndNil(qryGrava);
  Inherited;
end;

function TAtualizacaoCotacaoDolarNosCatalogos.fRetPrecoCusto: Double;
begin
  With cpcParams Do
  Begin
    cpcParams.curPreCom := FQry.FieldByName('CAT_PRECOM').AsFloat;
    curDesF01 := FQry.FieldByName('CAT_DESF01').AsFloat;
    curDesF02 := FQry.FieldByName('CAT_DESF02').AsFloat;
    curDesF03 := FQry.FieldByName('CAT_DESF03').AsFloat;
    curDesF04 := FQry.FieldByName('CAT_DESF04').AsFloat;
    curDesF05 := FQry.FieldByName('CAT_DESF05').AsFloat;
    curDesF06 := FQry.FieldByName('CAT_DESF06').AsFloat;
    curICMSEnt:= FQry.FieldByName('CAT_ICMENT').AsFloat;
    curIPIEnt := FQry.FieldByName('CAT_IPIENT').AsFloat;
    curFrete  := FQry.FieldByName('CAT_FREENT').AsFloat;
    curAcrFin := FQry.FieldByName('CAT_ACRFIN').AsFloat;
    curSubsti := FQry.FieldByName('CAT_SUBSTI').AsFloat;
    curValFre := FQry.FieldByName('CAT_VALFRE').AsFloat;
    curDesAdb := FQry.FieldByName('CAT_DESADB').AsFloat;
    curSubFed := FQry.FieldByName('CAT_SUBFED').AsFloat;

    if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
    begin
      curTCIFCu := FQry.FieldByName('CAT_TCIFCU').AsFloat;
      curTSCust := FQry.FieldByName('CAT_TSCUST').AsFloat;
      curDePiCo := FQry.FieldByName('CAT_DEPICO').AsFloat;
      curDeICMS := FQry.FieldByName('CAT_DEICMS').AsFloat;
      curFatReg := FQry.FieldByName('CAT_FATREG').AsFloat;
    end
    else
    begin
      curTCIFCu := 0;
      curTSCust := 0;
      curDePiCo := 0;
      curDeICMS := 0;
      curFatReg := 0;
    end;
  End;
  Result := cpcParams.fCalculaPrecoCusto(true);
End;


function TAtualizacaoCotacaoDolarNosCatalogos.fCalcular(
  TipoCalculo: TCalculo): Boolean;

begin
  FTipoCalculo := TipoCalculo;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Aguarde...Processando Itens.';
      frmGravando.fExecutarAcao := fCalculaPrecoMargem;
      FCaption             := TLabel.create(application);
      FCaption.Parent      := frmGravando;
      FCaption.Name        := 'lblContador';
      FCaption.Left        := 10;
      FCaption.Top         := 110;
      FCaption.Font.Height := 14;
      FCaption.Font.Name   := 'Arial';
      FCaption.Font.Pitch  := fpVariable;
      FCaption.Font.Style  := [fsBold];
      FCaption.Caption     := '';
      frmGravando.ShowModal;
      Result :=  frmGravando.blnConfirma;
    Finally
      FreeAndNil(frmGravando);
    End;
  Except
    On E:exception do
    Begin
 			pMensagensErro(E.Message,'[TAtualizacaoCotacaoDolarNosCatalogos.fCalcular]');
      Result := False;
    End;
  End;
end;


function  TAtualizacaoCotacaoDolarNosCatalogos.fCalculaPrecoMargem(pgbProgresso: TcxProgressBar): Boolean;
  var
    strMarMkp: String;
    fltIcmsSTParteVenda: Double;
    blnST: Boolean;
    i: integer;

  function fGetIcmsSTParteVenda(var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;
    Var
      strCodSit : String;
  begin
    Result := 0.00;
    blnST := False;
    If (strMarMkp = '4') And (Not fEmptyStr(strCodAbf)) Then
    Begin
      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [strCodAbf, strEstEmp]);
      Result := untIcmsSTParteVenda.fGetIcmsSTParteVenda(strCodAbf, '_SAI_CCO', strCodSit, strEstEmp, fltPreComLiq, fltIpiEnt, fltImcSai, strEstEmp, blnST, strMarMkp);
    End;
  end;

  function fIcmsSTParteVenda: Double;
  Begin
    If strMarMkp = '4'  Then
     Result  := fGetIcmsSTParteVenda(blnST, FQry.FieldByName('CAT_CODABF').AsString,
                            fCalculaPrecoCompraLiq(FQry.FieldByName('CAT_PRECOM').AsFloat,
                                                   FQry.FieldByName('CAT_DESF01').AsFloat,
                                                   FQry.FieldByName('CAT_DESF02').AsFloat,
                                                   FQry.FieldByName('CAT_DESF03').AsFloat,
                                                   FQry.FieldByName('CAT_DESF04').AsFloat,
                                                   FQry.FieldByName('CAT_DESF05').AsFloat,
                                                   FQry.FieldByName('CAT_DESF06').AsFloat,
                                                   intDecUni,
                                                   FQry.FieldByName('CAT_PREDOL').AsString = 'S'),
                                                   FQry.FieldByName('CAT_IPIENT').AsFloat,
                                                   FQry.FieldByName('CAT_ICMSAI').AsFloat)
    Else
    Begin
      blnST := False;
      Result := 0;
    End;
  End;

  function fRetPrecVenda(strTabPreco: string): Double;
  Begin
    Result := fCalculaPrecoVenda(IIf(FTipoCalculo = tcPrecoVenda, 1, 2),
                                 FQry.FieldByName('CAT_PRECUS_NOV').AsFloat + FQry.FieldByName('CAT_OUTVAL').AsFloat,
                                 FQry.FieldByName('CAT_PREVE' + strTabPreco).AsFloat,
                                 FQry.FieldByName('CAT_MARBR' + strTabPreco).AsFloat,
                                 FQry.FieldByName('CAT_ICMSAI').AsFloat,
                                 FQry.FieldByName('CAT_IMPFED').AsFloat,
                                 FQry.FieldByName('CAT_DESOPE').AsFloat,
                                 FQry.FieldByName('CAT_COMTB' + strTabPreco).AsFloat,
                                 '',
                                 '',
                                 -1,
                                 fltIcmsSTParteVenda,
                                 blnST);
  End;

Begin
  Fprogress := pgbProgresso;
  Fprogress.Properties.Max := FQry.RecordCount;
  Fprogress.Position := 0;
  HorIni := fNow;
  qtdSegundos := 0;
  ValidacoesPorSegundo := 0;
  intQtdProcess := 0;
  TempoExtimado := '';
  ultimaValidacao := 0;
  Try
    While not FQry.Eof do
    Begin
      FQry.Edit;
      fltIcmsSTParteVenda := fIcmsSTParteVenda;
      FQry.FieldByname('CAT_PRECUS_NOV').AsFloat := fRetPrecoCusto;
      For i:= 1 To Length(VS_strTabPrc) Do
      Begin
        If FTipoCalculo = tcPrecoVenda Then
          FQry.FieldByname('CAT_PREVE' + IntToStr(i) + '_NOV').AsFloat := fRetPrecVenda(IntToStr(i))
        Else
          FQry.FieldByname('CAT_MARBR' + IntToStr(i) + '_NOV').AsFloat := fRetPrecVenda(IntToStr(i));
      End;
      Inc(intQtdProcess);

      FQry.Post;
      FQry.Next;
      pCalculaTempo(False);

    End;
    FQry.First;
    Result := True;

  Except
    On e: Exception Do
      raise Exception.Create(e.Message);
  End;

End;


function TAtualizacaoCotacaoDolarNosCatalogos.fCarregar(strCodFor, strCodmar, strCodUni: string; Situacao: TSituacao): Boolean;
  var i : integer;
begin
  if FQry.qryQuery.SQL.Text <> '' then
  Begin
    FreeAndNil(FQry);
    FQry := TZClient.Create(nil, '');
  End;

  FQry.qryQuery.SQL.Clear;
  FQry.qryQuery.SQL.Add('SELECT ');

  FQry.qryQuery.SQL.Add('  ITE_PREDOL AS ITE_PREDOL_ANT,');
  For i := 1 To Length(VS_strTabPrc) Do
  Begin
    FQry.qryQuery.SQL.Add('  ITE_COMTB' + IntToStr(i) + ' AS CAT_COMTB' + IntToStr(i) +',')
  End;
    FQry.qryQuery.SQL.Add('  CAT.* ');
  FQry.qryQuery.SQL.Add(' FROM (');
  FQry.qryQuery.SQL.Add('  SELECT');
  FQry.qryQuery.SQL.Add('  CAT_CODFAB AS CODFAB,');
  FQry.qryQuery.SQL.Add('  CAT_DESITE AS DESITE,');
  FQry.qryQuery.SQL.Add('  CAT_CODUNI AS CODUNI,');
  FQry.qryQuery.SQL.Add('  UNI_SIGUNI,');
  FQry.qryQuery.SQL.Add('  CAT_PRECOM,');
  FQry.qryQuery.SQL.Add('  CAT_PRECUS,');
  FQry.qryQuery.SQL.Add('  CAT_PRECUS AS CAT_PRECUS_NOV,');
  For i:= 1 To Length(VS_strTabPrc) Do
  Begin
    FQry.qryQuery.SQL.Add('  CAT_PREVE'+ IntToStr(i) + ' AS CAT_PREVE' + IntToStr(i) + ',');
    FQry.qryQuery.SQL.Add('  CAT_PREVE'+ IntToStr(i) + ' AS CAT_PREVE' + IntToStr(i) + '_NOV,');
    FQry.qryQuery.SQL.Add('  CAT_MARBR'+ IntToStr(i) + ' AS CAT_MARBR' + IntToStr(i) + ',');
    FQry.qryQuery.SQL.Add('  CAT_MARBR'+ IntToStr(i) + ' AS CAT_MARBR' + IntToStr(i) + '_NOV,');
  End;
  FQry.qryQuery.SQL.Add('  CAT_CODFOR,');
  FQry.qryQuery.SQL.Add('  CAT_CODMAR,');
  FQry.qryQuery.SQL.Add('  CAT_DESF01,');
  FQry.qryQuery.SQL.Add('  CAT_DESF02,');
  FQry.qryQuery.SQL.Add('  CAT_DESF03,');
  FQry.qryQuery.SQL.Add('  CAT_DESF04,');
  FQry.qryQuery.SQL.Add('  CAT_DESF05,');
  FQry.qryQuery.SQL.Add('  CAT_DESF06,');
  FQry.qryQuery.SQL.Add('  CAT_ICMENT,');
  FQry.qryQuery.SQL.Add('  CAT_IPIENT,');
  FQry.qryQuery.SQL.Add('  CAT_FREENT,');
  FQry.qryQuery.SQL.Add('  CAT_ACRFIN,');
  FQry.qryQuery.SQL.Add('  CAT_DTAATI,');
  FQry.qryQuery.SQL.Add('  CAT_SUBSTI,');
  FQry.qryQuery.SQL.Add('  CAT_VALFRE,');
  FQry.qryQuery.SQL.Add('  CAT_DESADB,');
  FQry.qryQuery.SQL.Add('  CAT_OUTVAL,');
  FQry.qryQuery.SQL.Add('  CAT_SUBFED,');
  FQry.qryQuery.SQL.Add('  CAT_IMPFED,');
  FQry.qryQuery.SQL.Add('  CAT_ICMSAI,');
  FQry.qryQuery.SQL.Add('  CAT_PREDOL, ');
  FQry.qryQuery.SQL.Add('  CAT_DESOPE, ');
  FQry.qryQuery.SQL.Add('  CAT_TCIFCU, ');
  FQry.qryQuery.SQL.Add('  CAT_TSCUST, ');
  FQry.qryQuery.SQL.Add('  CAT_DEPICO, ');
  FQry.qryQuery.SQL.Add('  CAT_DEICMS, ');
  FQry.qryQuery.SQL.Add('  CAT_FATREG, ');
  FQry.qryQuery.SQL.Add('  (SELECT C.ITE_CODITE FROM CADITE C WHERE IFNULL(C.ITE_CODFAB, "") <> "" AND C.ITE_CODFAB = CAT_CODFAB AND C.ITE_CODFOR = CAT_CODFOR ORDER BY C.ITE_ITEATI DESC LIMIT 1)     AS CAT_CODITE ');
  FQry.qryQuery.SQL.Add(' FROM CATITE ');

  FQry.qryQuery.SQL.Add(' LEFT JOIN CADUNI ON UNI_CODUNI = CAT_CODUNI ');
  FQry.qryQuery.SQL.Add(' WHERE TRUE ');


  FQry.qryQuery.SQL.Add(fStrLocate(strCodFor, arrLinFor, 'CAT_CODFOR', 'CODFOR'));
  FQry.qryQuery.SQL.Add(fStrLocate(strCodmar, arrLinMar, 'CAT_CODMAR', 'CODMAR'));
  FQry.qryQuery.SQL.Add(fStrLocate(strCodUni, arrLinUni, 'CAT_CODUNI', 'CODUNI'));
  FQry.qryQuery.SQL.Add(' AND CAT_PREDOL = "S" ');
  FQry.qryQuery.SQL.Add(' ) AS CAT ');
  FQry.qryQuery.SQL.Add('LEFT JOIN CADITE ON CADITE.ITE_CODITE = CAT.CAT_CODITE');
  FQry.qryQuery.SQL.Add('LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = "'+ VS_StrCodEmp +'"');
  FQry.qryQuery.SQL.Add(' WHERE TRUE ');

  Case Situacao Of
    stAtivo  : FQry.qryQuery.SQL.Add(' AND CAT_DTAATI IS NOT NULL ');
    stInativo: FQry.qryQuery.SQL.Add(' AND CAT_DTAATI IS NULL ');
  End;

  pSetaParam(strCodFor, arrLinFor, strLinFor, 'CODFOR', FQry.qryQuery);
  pSetaParam(strCodmar, arrLinMar, strLinMar, 'CODMAR', FQry.qryQuery);
  pSetaParam(strCodUni, arrLinUni, strLinUni, 'CODUNI', FQry.qryQuery);


  FQry.fAbreClient(True, 'TAtualizacaoCotacaoDolarNosCatalogos.fCarregar');

  Result := Not (FQry.IsEmpty);

end;

function TAtualizacaoCotacaoDolarNosCatalogos.fGetValorDolar: Double;
begin
  FValorDolar := fGetUltimaCotacaoDolarVenda;
  Result := FValorDolar;

end;


function TAtualizacaoCotacaoDolarNosCatalogos.fTrataTextoTempo(segundos: Integer): String;
var
  Seg, Min, Hora: Cardinal;

begin
  Result := '';
  Hora := Segundos div 3600;
  Seg := Segundos mod 3600;
  Min := Seg div 60;
  Seg := Seg mod 60;
  If Hora > 0 Then
    Result := FormatFloat('00', Hora) + 'hs. ';
  If Min > 0 Then
     Result :=  Result + FormatFloat('00', Min) + 'min. ';
  Result :=  Result + FormatFloat('00', Seg + 1) + 'seg. '
end;


procedure TAtualizacaoCotacaoDolarNosCatalogos.pCalculaTempo(blnGravacao: Boolean);
begin

  If (ultimaValidacao = 0) Or (MilliSecondsBetween(fNow, ultimaValidacao) > 500) Then
  Begin
    ultimaValidacao := fNow;
    Fprogress.Position := intQtdProcess;
    qtdSegundos := SecondsBetween(fNow, HorIni);
    ValidacoesPorSegundo := Round(intQtdProcess/qtdSegundos);
    TempoExtimado := fTrataTextoTempo(Trunc((FQry.RecordCount - intQtdProcess)/ValidacoesPorSegundo));
    If blnGravacao Then
      FCaption.Caption := 'Atualizando os catálogos...  '+ IntToStr(intQtdProcess) + '/' + IntToStr(FQry.RecordCount ) + ' Qtd. Por Segundo: ' + IntToStr(ValidacoesPorSegundo) + ' Tempo Estimado: ' + TempoExtimado
    Else
    Begin
      If FTipoCalculo = tcPrecoVenda Then
        FCaption.Caption := 'Calculando Preço de Venda...  '+ IntToStr(intQtdProcess) + '/' + IntToStr(FQry.RecordCount ) + ' Qtd. Por Segundo: ' + IntToStr(ValidacoesPorSegundo) + ' Tempo Estimado: ' + TempoExtimado
      Else
        FCaption.Caption := 'Calculando Margem...  '+ IntToStr(intQtdProcess) + '/' + IntToStr(FQry.RecordCount ) + ' Qtd. Por Segundo: ' + IntToStr(ValidacoesPorSegundo) + ' Tempo Estimado: ' + TempoExtimado;
    End;

    Application.ProcessMessages;
  End;
End;

procedure TAtualizacaoCotacaoDolarNosCatalogos.pIncluiPreIteCatalogo(qryGenIte: TUniQuery; qryGenGlo: TDataSet; dtaDtaAlt: TDate; strNomFrm, strProPri: String;
                        blnPreDol: Boolean = False);
begin

  qryGenIte.SQL.Text := '';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + 'REPLACE INTO      ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  PREITE         ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '(PRE_DTAPRE,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_CODITE,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_CODEMP,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' AUTOINCREM,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PRECOM_ANT, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PRECOM,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESF01,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESF02,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESF03,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESF04,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESF05,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESF06,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_ICMENT,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_SUBFED,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_IPIENT,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_FREENT,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_VALFRE,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_ACRFIN,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_SUBSTI,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESADB,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_OUTVAL,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_ICMSAI,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_IMPFED,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DESOPE,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PRECUS,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PRECUS_NOV, ';

  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_COMTB1,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_COMTB2,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_COMTB3,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_COMTB4,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_COMTB5,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_COMTB6,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_COMTB7,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR1,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR1_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE1,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE1_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR2,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR2_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE2,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE2_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR3,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR3_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE3,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE3_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR4,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR4_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE4,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE4_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR5,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR5_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE5,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE5_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR6,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR6_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE6,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREVE6_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR7,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_MARBR7_NOV, ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_TCIFCU,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_TSCUST,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DEPICO,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_DEICMS,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_FATREG,     ';


  If blnPreDol Then
  Begin
    qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREDOL,       ';
    qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PREDOL_NOV,   ';
  End;

  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_NOMFRM,     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + ' PRE_PROPRI)     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '    VALUES (     ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DTAPRE,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :CODITE,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :CODEMP,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :AUTOIN,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PRECOM_ANT,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PRECOM,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESF01,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESF02,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESF03,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESF04,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESF05,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESF06,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :ICMENT,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :SUBFED,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :IPIENT,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :FREENT,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :VALFRE,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :ACRFIN,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :SUBSTI,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESADB,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :OUTVAL,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :ICMSAI,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :IMPFED,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DESOPE,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PRECUS,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PRECUS_NOV,   ';

  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :COMTB1,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :COMTB2,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :COMTB3,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :COMTB4,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :COMTB5,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :COMTB6,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :COMTB7,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR1,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR1_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE1,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE1_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR2,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR2_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE2,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE2_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR3,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR3_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE3,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE3_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR4,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR4_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE4,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE4_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR5,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR5_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE5,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE5_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR6,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR6_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE6,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE6_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR7,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :MARBR7_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE7,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREVE7_NOV,   ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :TCIFCU,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :TSCUST,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DEPICO,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :DEICMS,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :FATREG,       ';


  If blnPreDol Then
  Begin
    qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREDOL,       ';
    qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PREDOL_NOV,   ';
  End;

  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :NOMFRM,       ';
  qryGenIte.SQL.Text := qryGenIte.SQL.Text + '  :PROPRI)       ';

  With qryGenGlo Do
  Begin
    qryGenIte.ParamByName('PRECOM').Value     := FieldByName('CAT_PRECOM').Value;
    qryGenIte.ParamByName('PRECOM_ANT').Value := FieldByName('CAT_PRECOM').Value;
    qryGenIte.ParamByName('DESF01').Value     := FieldByName('CAT_DESF01').Value;
    qryGenIte.ParamByName('DESF02').Value     := FieldByName('CAT_DESF02').Value;
    qryGenIte.ParamByName('DESF03').Value     := FieldByName('CAT_DESF03').Value;
    qryGenIte.ParamByName('DESF04').Value     := FieldByName('CAT_DESF04').Value;
    qryGenIte.ParamByName('DESF05').Value     := FieldByName('CAT_DESF05').Value;
    qryGenIte.ParamByName('DESF06').Value     := FieldByName('CAT_DESF06').Value;
    qryGenIte.ParamByName('ICMENT').Value     := FieldByName('CAT_ICMENT').Value;
    qryGenIte.ParamByName('SUBFED').Value     := FieldByName('CAT_SUBFED').Value;
    qryGenIte.ParamByName('IPIENT').Value     := FieldByName('CAT_IPIENT').Value;
    qryGenIte.ParamByName('FREENT').Value     := FieldByName('CAT_FREENT').Value;
    qryGenIte.ParamByName('VALFRE').Value     := FieldByName('CAT_VALFRE').Value;
    qryGenIte.ParamByName('ACRFIN').Value     := FieldByName('CAT_ACRFIN').Value;
    qryGenIte.ParamByName('SUBSTI').Value     := FieldByName('CAT_SUBSTI').Value;
    qryGenIte.ParamByName('DESADB').Value     := FieldByName('CAT_DESADB').Value;
    qryGenIte.ParamByName('OUTVAL').Value     := FieldByName('CAT_OUTVAL').Value;
    qryGenIte.ParamByName('ICMSAI').Value     := FieldByName('CAT_ICMSAI').Value;
    qryGenIte.ParamByName('IMPFED').Value     := FieldByName('CAT_IMPFED').Value;
    qryGenIte.ParamByName('DESOPE').Value     := FieldByName('CAT_DESOPE').Value;
    qryGenIte.ParamByName('PRECUS').Value     := FieldByName('CAT_PRECUS').Value;
    qryGenIte.ParamByName('PRECUS_NOV').Value := FieldByName('CAT_PRECUS_NOV').Value;

    qryGenIte.ParamByName('COMTB1').Value     := FieldByName('CAT_COMTB1').Value;
    qryGenIte.ParamByName('COMTB2').Value     := FieldByName('CAT_COMTB2').Value;
    qryGenIte.ParamByName('COMTB3').Value     := FieldByName('CAT_COMTB3').Value;
    qryGenIte.ParamByName('COMTB4').Value     := FieldByName('CAT_COMTB4').Value;
    qryGenIte.ParamByName('COMTB5').Value     := FieldByName('CAT_COMTB5').Value;
    qryGenIte.ParamByName('COMTB6').Value     := FieldByName('CAT_COMTB6').Value;
    qryGenIte.ParamByName('COMTB7').Value     := FieldByName('CAT_COMTB7').Value;
    qryGenIte.ParamByName('MARBR1').Value     := FieldByName('CAT_MARBR1').Value;
    qryGenIte.ParamByName('MARBR1_NOV').Value := FieldByName('CAT_MARBR1_NOV').Value;
    qryGenIte.ParamByName('PREVE1').Value     := FieldByName('CAT_PREVE1').Value;
    qryGenIte.ParamByName('PREVE1_NOV').Value := FieldByName('CAT_PREVE1_NOV').Value;
    qryGenIte.ParamByName('MARBR2').Value     := FieldByName('CAT_MARBR2').Value;
    qryGenIte.ParamByName('MARBR2_NOV').Value := FieldByName('CAT_MARBR2_NOV').Value;
    qryGenIte.ParamByName('PREVE2').Value     := FieldByName('CAT_PREVE2').Value;
    qryGenIte.ParamByName('PREVE2_NOV').Value := FieldByName('CAT_PREVE2_NOV').Value;
    qryGenIte.ParamByName('MARBR3').Value     := FieldByName('CAT_MARBR3').Value;
    qryGenIte.ParamByName('MARBR3_NOV').Value := FieldByName('CAT_MARBR3_NOV').Value;
    qryGenIte.ParamByName('PREVE3').Value     := FieldByName('CAT_PREVE3').Value;
    qryGenIte.ParamByName('PREVE3_NOV').Value := FieldByName('CAT_PREVE3_NOV').Value;
    qryGenIte.ParamByName('MARBR4').Value     := FieldByName('CAT_MARBR4').Value;
    qryGenIte.ParamByName('MARBR4_NOV').Value := FieldByName('CAT_MARBR4_NOV').Value;
    qryGenIte.ParamByName('PREVE4').Value     := FieldByName('CAT_PREVE4').Value;
    qryGenIte.ParamByName('PREVE4_NOV').Value := FieldByName('CAT_PREVE4_NOV').Value;
    qryGenIte.ParamByName('MARBR5').Value     := FieldByName('CAT_MARBR5').Value;
    qryGenIte.ParamByName('MARBR5_NOV').Value := FieldByName('CAT_MARBR5_NOV').Value;
    qryGenIte.ParamByName('PREVE5').Value     := FieldByName('CAT_PREVE5').Value;
    qryGenIte.ParamByName('PREVE5_NOV').Value := FieldByName('CAT_PREVE5_NOV').Value;
    qryGenIte.ParamByName('MARBR6').Value     := FieldByName('CAT_MARBR6').Value;
    qryGenIte.ParamByName('MARBR6_NOV').Value := FieldByName('CAT_MARBR6_NOV').Value;
    qryGenIte.ParamByName('PREVE6').Value     := FieldByName('CAT_PREVE6').Value;
    qryGenIte.ParamByName('PREVE6_NOV').Value := FieldByName('CAT_PREVE6_NOV').Value;
    qryGenIte.ParamByName('MARBR7').Value     := FieldByName('CAT_MARBR7').Value;
    qryGenIte.ParamByName('MARBR7_NOV').Value := FieldByName('CAT_MARBR7_NOV').Value;
    qryGenIte.ParamByName('PREVE7').Value     := FieldByName('CAT_PREVE7').Value;
    qryGenIte.ParamByName('PREVE7_NOV').Value := FieldByName('CAT_PREVE7_NOV').Value;
    qryGenIte.ParamByName('TCIFCU').Value     := FieldByName('CAT_TCIFCU').Value;
    qryGenIte.ParamByName('TSCUST').Value     := FieldByName('CAT_TSCUST').Value;
    qryGenIte.ParamByName('DEPICO').Value     := FieldByName('CAT_DEPICO').Value;
    qryGenIte.ParamByName('DEICMS').Value     := FieldByName('CAT_DEICMS').Value;
    qryGenIte.ParamByName('FATREG').Value     := FieldByName('CAT_FATREG').Value;
    qryGenIte.ParamByName('CODITE').AsString    := FieldByName('CAT_CODITE').AsString;
    qryGenIte.ParamByName('DTAPRE').AsDateTime  := dtaDtaAlt;
    qryGenIte.ParamByName('CODEMP').AsString    := VS_strCodEmp;
    qryGenIte.ParamByName('AUTOIN').AsString    := fRetAutoIncrem('PREITE', VS_strCodEmp);
    qryGenIte.ParamByName('NOMFRM').AsString    := strNomFrm;
    qryGenIte.ParamByName('PROPRI').AsString    := strProPri;

    If blnPreDol Then
    Begin
      qryGenIte.ParamByName('PREDOL_NOV').Value := 'S';
      qryGenIte.ParamByName('PREDOL').Value     := FieldByName('ITE_PREDOL_ANT').Value;
    End;

  End;
  qryGenIte.ExecSQL;
  qryGenIte.Close;
end;




end.
