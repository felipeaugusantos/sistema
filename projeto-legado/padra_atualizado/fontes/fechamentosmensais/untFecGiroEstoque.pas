unit untFecGiroEstoque;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untBaseFechamento, EditFocus, ComCtrls, Buttons,
  ExtCtrls, DateUtils, StrUtils, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFecGiroEstoque = class(TfrmBaseFechamento)
    tmrClose: TTimer;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
  private
    { Private declarations }

    blnMetod2: Boolean;

    blnCalculando: Boolean;

    arrMeses: Array Of Integer;

    arrPeriodo: Array[1..4] Of Record
                                 dtaDtaIni,
                                 dtaDtaFin: TDate;
                               End;

    Procedure pPrencheArrPeriodo;
    procedure pHabilitaCheckBox;
    procedure pDesabilitaCheckBox(blnTodos: Boolean);
    procedure pPrencheArrMeses;
    procedure pZeraMesesSelecionados;
    procedure pZeraMesesSelecionadosMetodo2;
    procedure pInativaCompraItensSemVendas;

    procedure pCalcularGiroTrocaCodigo;

    function fProcessaCadIte: Boolean;
    function fRealizaCalculoGiro(blnSaida: Boolean; intTamMat: Integer): Boolean;

    Function fRetDataMaiorCompra(IntAno, intMes: Integer;
                                 strCodIte, strEspMax, strTabela: String;
                                 fltQtdSai: Double): TDate;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnGerarAutomatico: Boolean;
    blnAutoGiro: Boolean;
    dtaDtaTmp: TDateTime;
    strItemGiro: String;
    strEmpGiro: String;
    blnControlaTransacao: Boolean;
  end;

var
  frmFecGiroEstoque: TfrmFecGiroEstoque;

implementation

uses untfuncoesSimples, untPai, DB, untGiroProdutos,
     untBloqueioProdutos;

{$R *.dfm}

{ TfrmFecGiroEstoque }

function TfrmFecGiroEstoque.fRealizaCalculoGiro(blnSaida: Boolean; intTamMat: Integer): Boolean;
  Var
    strSQL: String;
    intContador: Integer;
    qryGenFis  : TUniQuery;
    strItemAnt : String;
    fltCnvMlAnt: Double;
    intMesAnt: Integer;
    intAnoAnt: Integer;
    fltQtdSaiMl: Double;
    fltQtdSai: Double;
    fltQtdEnt: Double;
    strTabela: String;
    strEspMax: String;
    fltQtdMax: Double;
    dtaDtaFin: TDateTime;
    dtaDtaIni: TDateTime;
    dtaMaiorDtaSai: TDateTime;
    fltMaiorQtdSai: Double;
    dtaDtaIniFil : TDateTime;
    dtaDtaFinFil : TDateTime;
begin
  qryGenFis := fCriaQuery(Self);
  Result := True;

  strSQL := '';
  strSQL := strSQL + '(SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  "MOVDET" AS TABELA, ';
  strSQL := strSQL + '  IF(IFNULL(DET_ESPDOC, "") = "ML", "ML", "XX") AS DET_ESP_ML, ';
  strSQL := strSQL + '  ITE_CODITE, ';

  If blnSaida Then
  Begin
    strSQL := strSQL + '  MAX(IFNULL(IF(DET_CLAFIS<5000, -1, 1) * DET_QTDITE,0)) AS DET_MAXQTD, ';
    strSQL := strSQL + '  SUM(IFNULL(IF(DET_CLAFIS<5000, -1, 1) * DET_QTDITE,0)) AS DET_QTDITE, ';
  End
  Else
  Begin
    strSQL := strSQL + '  MAX(IFNULL(DET_QTDITE,0)) AS DET_MAXQTD, ';
    strSQL := strSQL + '  SUM(IFNULL(DET_QTDITE,0)) AS DET_QTDITE, ';
  End;

  If blnMetod2 Then
  Begin
    strSQL := strSQL + '(CASE WHEN DET_DTAENT BETWEEN :DTAIN1 AND :DTAFI1 THEN MONTH(:DTAFI1) ';
    strSQL := strSQL + '      WHEN DET_DTAENT BETWEEN :DTAIN2 AND :DTAFI2 THEN MONTH(:DTAFI2) ';
    strSQL := strSQL + '      WHEN DET_DTAENT BETWEEN :DTAIN3 AND :DTAFI3 THEN MONTH(:DTAFI3) ';
    strSQL := strSQL + '      WHEN DET_DTAENT BETWEEN :DTAIN4 AND :DTAFI4 THEN MONTH(:DTAFI4) ';
    strSQL := strSQL + '  END) AS DET_MESENT,                                                 ';

    strSQL := strSQL + '(CASE WHEN DET_DTAENT BETWEEN :DTAIN1 AND :DTAFI1 THEN YEAR(:DTAFI1) ';
    strSQL := strSQL + '      WHEN DET_DTAENT BETWEEN :DTAIN2 AND :DTAFI2 THEN YEAR(:DTAFI2) ';
    strSQL := strSQL + '      WHEN DET_DTAENT BETWEEN :DTAIN3 AND :DTAFI3 THEN YEAR(:DTAFI3) ';
    strSQL := strSQL + '      WHEN DET_DTAENT BETWEEN :DTAIN4 AND :DTAFI4 THEN YEAR(:DTAFI4) ';
    strSQL := strSQL + '  END) AS DET_ANOENT, ';
  End Else
  Begin
    strSQL := strSQL + '  MONTH(DET_DTAENT) AS DET_MESENT, ';
  End;

  strSQL := strSQL + '  ' + IIF(blnSaida, '"S"', '"E"') + ' AS DET_ENTSAI, ';
  strSQL := strSQL + '  ITE_CNV_ML ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + '  LEFT JOIN MOVDET ON ITE_CODITE = DET_CODITE AND ';

  strSQL := strSQL + '  DET_FILKAR = "FALSE"    AND ';
    
  strSQL := strSQL + '  DET_QTDITE > 0          AND ';

  If (Not fCfgSis('CFLGIR', varBoolean)) Then
    If (blnSaida) Then
      strSQL := strSQL + ' DET_CODCLI NOT IN ('  + fRetClientesFilial + ') AND ';

  strSQL := strSQL + ' DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + ' ( ';

  If (blnSaida) Then
  Begin
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAGIR) > 0) AND (LOCATE(DET_ESPDOC, :ESPGIR) > 0)) OR ';
    strSQL := strSQL + '   ((DET_ESPDOC = "ML") AND (IFNULL(DET_TIPFAT,"") <> "AJ")) )  ';
  End
  Else
  Begin
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLACOM) > 0) AND (DET_TIP_FC="F")))  ';
  End;
  strSQL := strSQL + IIF(Not fEmptyStr(strItemGiro), ' AND ', ' WHERE ') + ' (';

  If blnMetod2 Then
  Begin
    dtaDtaFin := VS_Date - 1;
    dtaDtaIni := IncMonth(dtaDtaFin, -4) + 1;

    strSQL := strSQL + ' (DET_DTAENT BETWEEN ';
    strSQL := strSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', dtaDtaIni));
    strSQL := strSQL + ' AND ';
    strSQL := strSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', dtaDtaFin)) + ' )';

  End Else
  Begin

    dtaDtaIniFil := 0;
    dtaDtaFinFil := 0;

    For intContador := 0 To intTamMat -1 Do
    Begin

      If blnGerarAutomatico Then
      Begin

        If YearOf(dtaDtaTmp) <> YearOf(StrToDate('01' + FormatSettings.DateSeparator + '01' + FormatSettings.DateSeparator + edtAno.Text)) Then
        Begin

          If arrMeses[intContador] = 12 Then
            dtaDtaIni := EncodeDate(YearOf(dtaDtaTmp), arrMeses[intContador], 01)
          Else
            dtaDtaIni := EncodeDate(StrToInt(edtAno.Text), arrMeses[intContador], 01);

        End
        Else
          dtaDtaIni := EncodeDate(StrToInt(edtAno.Text), arrMeses[intContador], 01);

      End
      Else
        dtaDtaIni := EncodeDate(StrToInt(edtAno.Text), arrMeses[intContador], 01);

      dtaDtaFin := EndOfTheMonth(dtaDtaIni);

      If (dtaDtaIniFil = 0) Or (dtaDtaIni < dtaDtaIniFil) Then
        dtaDtaIniFil := dtaDtaIni;

      If (dtaDtaFinFil = 0) Or (dtaDtaFin > dtaDtaFinFil) Then
        dtaDtaFinFil := dtaDtaFin;

//      strSQL := strSQL + ' (DET_DTAENT BETWEEN ';
//      strSQL := strSQL + QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaIni));
//      strSQL := strSQL + ' AND ';
//      strSQL := strSQL + QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaFin)) + ' )';

//      If intContador < intTamMat -1 Then
//        strSQL := strSQL + ' OR ';

    End;

    If (dtaDtaIniFil <> 0) And (dtaDtaFinFil <> 0) Then
    Begin
      strSQL := strSQL + ' (DET_DTAENT BETWEEN ';
      strSQL := strSQL + QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaIniFil));
      strSQL := strSQL + ' AND ';
      strSQL := strSQL + QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaFinFil)) + ' )';
    End;

  End;

  strSQL := strSQL + ' ) ';

  If Not fEmptyStr(strItemGiro) Then
   strSQL := strSQL + ' WHERE ITE_CODITE = ' + QuotedStr(strItemGiro) + ' ';

  strSQL := strSQL + 'GROUP BY DET_ESP_ML, ITE_CODITE, IF(LEFT(DET_CLAFIS, 1) < 5, "E", "S"), ' ;

  If blnMetod2 Then
  Begin

    strSQL := strSQL + ' (CASE WHEN DET_DTAENT BETWEEN :DTAIN1 AND :DTAFI1 THEN YEAR(:DTAFI1) ';
    strSQL := strSQL + '       WHEN DET_DTAENT BETWEEN :DTAIN2 AND :DTAFI2 THEN YEAR(:DTAFI2) ';
    strSQL := strSQL + '       WHEN DET_DTAENT BETWEEN :DTAIN3 AND :DTAFI3 THEN YEAR(:DTAFI3) ';
    strSQL := strSQL + '       WHEN DET_DTAENT BETWEEN :DTAIN4 AND :DTAFI4 THEN YEAR(:DTAFI4) ';
    strSQL := strSQL + '  END), ';

    strSQL := strSQL + ' (CASE WHEN DET_DTAENT BETWEEN :DTAIN1 AND :DTAFI1 THEN MONTH(:DTAFI1) ';
    strSQL := strSQL + '       WHEN DET_DTAENT BETWEEN :DTAIN2 AND :DTAFI2 THEN MONTH(:DTAFI2) ';
    strSQL := strSQL + '       WHEN DET_DTAENT BETWEEN :DTAIN3 AND :DTAFI3 THEN MONTH(:DTAFI3) ';
    strSQL := strSQL + '       WHEN DET_DTAENT BETWEEN :DTAIN4 AND :DTAFI4 THEN MONTH(:DTAFI4) ';
    strSQL := strSQL + '  END)                                                 ';

  End Else
  Begin
    strSQL := strSQL + ' MONTH(DET_DTAENT) ' ;
  End;

  strSQL := strSQL + '  )' ;

  If blnMetod2 Then
  Begin
    strSQL := strSQL + ' ORDER BY ITE_CODITE, DET_ANOENT, DET_MESENT ';
  End Else
  Begin
    strSQL := strSQL + ' ORDER BY ITE_CODITE, DET_MESENT ';
  End;
      
  {*****************************************}
  {* PROCESSA O MOVDET                     *}
  {**************************************MV*}
  With qryGenFis Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := IIF(fEmptyStr(strEmpGiro), VS_strCodEmp, strEmpGiro);
    If (blnSaida) Then
    Begin
      ParamByName('CLAGIR').AsString := VS_strClaGir;
      ParamByName('ESPGIR').AsString := VS_strEspGir;
    End
    Else
    Begin
      ParamByName('CLACOM').AsString := VS_strClaCom;
    End;

    If blnMetod2 Then
    Begin

      For intContador := Low(arrPeriodo) To High(arrPeriodo) Do
      Begin
        ParamByName('DTAIN' + IntToStr(intContador)).AsDate := arrPeriodo[intContador].dtaDtaIni;
        ParamByName('DTAFI' + IntToStr(intContador)).AsDate := arrPeriodo[intContador].dtaDtaFin;
      End;

    End;

    Open;
    First;

    pgbProgresso.Max := RecordCount;
    pgbProgresso.Position := 0;

    {*****************************************}
    {* PROCESSA O MOVDET                     *}
    {**************************************MV*}
    While Not Eof Do
    Begin

      strItemAnt  := FieldbyName('ITE_CODITE').AsString;
      fltCnvMlAnt := FieldbyName('ITE_CNV_ML').AsFloat;

      {*****************************************}
      {* PROCESSA QUEBRANDO POR ITEM           *}
      {**************************************MV*}
      While (Not Eof) And (strItemAnt = FieldbyName('ITE_CODITE').AsString) Do
      Begin

        intMesAnt   := FieldByName('DET_MESENT').AsInteger;

        If blnMetod2 Then
          intAnoAnt := FieldByName('DET_ANOENT').AsInteger
        Else
          intAnoAnt := StrToInt(edtAno.Text);

        fltQtdSaiMl := 0.0;
        fltQtdSai   := 0.0;
        fltQtdEnt   := 0.0;

        strTabela      := '';
        strEspMax      := '';
        fltMaiorQtdSai := -1;
        fltQtdMax      := -1;
        //dtaMaiorDtaSai := 0;

        {*****************************************}
        {* PROCESSA QUEBRANDO ITEM + MES         *}
        {**************************************MV*}
        While (Not Eof)                                          And
              (strItemAnt = FieldbyName('ITE_CODITE').AsString)  And
              (intMesAnt  = FieldByName('DET_MESENT').AsInteger) And
              ((Not blnMetod2) Or (intAnoAnt  = FieldByName('DET_ANOENT').AsInteger)) Do
        Begin

          Application.ProcessMessages;

          If (LeftStr(FieldByName('DET_ENTSAI').AsString, 1) = 'E') Then
            fltQtdEnt := fltQtdEnt + FieldByName('DET_QTDITE').AsFloat
          Else
          Begin

            {*****************************************}
            {* CASO O ITEM TENHA FATOR TINTOMETRICO E*}
            {* O DOCUMENTO SEJA "ML", ACUMULA O TO-  *}
            {* TAL EM ML QUE SOMARÁ NO FIM.          *}
            {**************************************MV*}
            If (fltCnvMlAnt > 0) And (FieldByName('DET_ESP_ML').AsString = 'ML') Then
            Begin
              fltQtdSaiMl := fltQtdSaiMl + FieldByName('DET_QTDITE').AsFloat;

              If (FieldByName('DET_MAXQTD').AsFloat) > fFormataFloat(fltMaiorQtdSai, 3) Then
              Begin
                fltMaiorQtdSai := FieldByName('DET_MAXQTD').AsFloat;
                fltQtdMax      := FieldByName('DET_MAXQTD').AsFloat;
                strEspMax      := 'ML';
                strTabela      := FieldByName('TABELA').AsString;
                //dtaMaiorDtaSai := FieldByName('DET_DTAENT').AsDateTime;
              End;

            End
            Else
            Begin
              fltQtdSai := fltQtdSai + FieldByName('DET_QTDITE').AsFloat;

              If fFormataFloat(FieldByName('DET_MAXQTD').AsFloat * IIF(fltCnvMlAnt > 0, fltCnvMlAnt, 1), 3) > fltMaiorQtdSai Then
              Begin
                fltMaiorQtdSai := fFormataFloat(FieldByName('DET_MAXQTD').AsFloat * IIF(fltCnvMlAnt > 0, fltCnvMlAnt, 1), 3);
                //dtaMaiorDtaSai := FieldByName('DET_DTAENT').AsDateTime;

                fltQtdMax      := FieldByName('DET_MAXQTD').AsFloat;
                strEspMax      := '';
                strTabela      := FieldByName('TABELA').AsString;
              End;
            End;

          End;

          Next;
          pgbProgresso.StepBy(1);

          {*****************************************}
          {* CASO OCORRER ALGUM ERRO, SAI          *}
          {**************************************MV*}
          If Not Result Then
            Break;

        End;

        {*****************************************}
        {* SOMA O TOTAL EM ML CONVERTIDO EM      *}
        {* "EMBALAGEM". LEMBRANDO QUE: SE O TOTAL*}
        {* EM "ML" É 5,7 SIGNIFICA QUE FORAM USA-*}
        {* DAS 5 EMBALAGENS E 70% DE UMA QUE     *}
        {* AINDA ESTÁ NA MÁQUINA.                *}
        {**************************************MV*}
        fltQtdSai := fltQtdSai + (fltQtdSaiMl / IIF(fltCnvMlAnt > 0, fltCnvMlAnt, 1));

        If fltMaiorQtdSai < 0 Then
        Begin
          fltMaiorQtdSai := 0;
          fltQtdMax      := 0;
        End Else
          fltMaiorQtdSai := fFormataFloat(fltMaiorQtdSai / IIF(fltCnvMlAnt > 0, fltCnvMlAnt, 1), 2);

        If (intMesAnt = 0) Or (fltQtdMax = 0) Then
          dtaMaiorDtaSai := 0
        Else
          dtaMaiorDtaSai := fRetDataMaiorCompra(intAnoAnt,
                                                intMesAnt,
                                                strItemAnt,
                                                strEspMax,
                                                strTabela,
                                                fltQtdMax);

        Application.ProcessMessages;

        Result := fGravaGirIte(IntToStr(IIF(intAnoAnt > 0, intAnoAnt, YearOf(VS_Date))),
                                                    strItemAnt,
                                                    intMesAnt,
                                                    fltQtdEnt,
                                                    fltQtdSai,
                                                    fltMaiorQtdSai,
                                                    dtaMaiorDtaSai,
                                                    blnSaida,
                                                    strEmpGiro);

        {*****************************************}
        {* CASO OCORRER ALGUM ERRO, SAI          *}
        {**************************************MV*}
        If Not Result Then
          Break;

      End; {While}

      {*****************************************}
      {* CASO OCORRER ALGUM ERRO, SAI          *}
      {**************************************MV*}
      If Not Result Then
        Break;

    End;

  End;

  qryGenFis.Close;
  FreeAndNil(qryGenFis);
end;

Function TfrmFecGiroEstoque.fRetDataMaiorCompra(IntAno, intMes: Integer;
                                                strCodIte, strEspMax, strTabela: String;
                                                fltQtdSai: Double): TDate;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                      ';
  strSQL := strSQL + '   DET_DTAENT                                ';
  strSQL := strSQL + ' FROM ' + strTabela;
  strSQL := strSQL + ' WHERE                                       ';
  strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) >= 5               AND ';
  strSQL := strSQL + '  DET_CODITE = :CODITE                   AND ';
  strSQL := strSQL + '  DET_QTDITE = :QTDITE                   AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

  If Not fCfgSis('CFLGIR', varBoolean) Then
    strSQL := strSQL + ' DET_CODCLI NOT IN ('  + fRetClientesFilial + ') AND ';

  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + ' ( ';
  strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAGIR) > 0) AND (LOCATE(DET_ESPDOC, :ESPGIR) > 0)) OR ';
  strSQL := strSQL + '   (DET_ESPDOC = "ML") ) AND ';

  If strEspMax = 'ML' Then
    strSQL := strSQL + ' DET_ESPDOC =  "ML" '
  Else
    strSQL := strSQL + ' DET_ESPDOC <> "ML" ';

  strSQL := strSQL + ' ORDER BY DET_DTAENT DESC LIMIT 1' ;

  qryGen := fCriaQuery(Self);
  With qryGen do
  Begin
    SQL.Text := strSQL;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('QTDITE').AsFloat  := fltQtdSai;

    ParamByName('DTAINI').AsDate   := EncodeDate(IntAno, intMes, 01);
    ParamByName('DTAFIN').AsDate   := EndOfTheMonth(ParamByName('DTAINI').AsDate);

    ParamByName('CODEMP').AsString := IIF(fEmptyStr(strEmpGiro), VS_strCodEmp, strEmpGiro);;
    ParamByName('CLAGIR').AsString := VS_strClaGir;
    ParamByName('ESPGIR').AsString := VS_strEspGir;

    Open;

    If IsEmpty Or FieldByName('DET_DTAENT').IsNull Then
      Result := 0
    Else
      Result := FieldByName('DET_DTAENT').AsDateTime;

    Close;
  End;
  FreeAndNil(qryGen);
End;

Procedure TfrmFecGiroEstoque.pPrencheArrPeriodo;
  Var
    intContador: Integer;
    dtaDtaIni  : TDate;
Begin
  dtaDtaIni := VS_Date - 1;

  For intContador := Low(arrPeriodo) To High(arrPeriodo) Do
  Begin
    arrPeriodo[intContador].dtaDtaFin := dtaDtaIni;
    arrPeriodo[intContador].dtaDtaIni := IncMonth(dtaDtaIni, -1) + 1;

    dtaDtaIni := IncMonth(dtaDtaIni, -1);
  End;
End;

{*****************************************}
{* PROCESSA O CADASTRO DE ITENS, GRAVAN- *}
{* DO A MOVIMENTAÇÃO NO GIRO DE ESTOQUE, *}
{* CASO HOUVER                           *}
{**************************************MV*}
function TfrmFecGiroEstoque.fProcessaCadIte: Boolean;
  Var
    blnConfirma: Boolean;
    intTamMat: Integer;
begin
  intTamMat := 0;

  {*****************************************}
  {* PREENCHE O VETOR COM OS MESES SELECIO-*}
  {* NADOS                                 *}
  {**************************************MV*}

  If Not blnMetod2 Then
  Begin

    pPrencheArrMeses;
    intTamMat := Length(arrMeses);

    If (intTamMat = 0) Then
    Begin

      fMensagem('', 'É Necessario escolher um mês!', ['&O k']);
      Result := False;
      Exit;

    End;

  End;

  Try
    If blnControlaTransacao Then
      fStartTransaction;

    {*****************************************}
    {* ZERA AS QUANTIDADES DOS MESES SEL.    *}
    {**************************************MV*}
    If blnMetod2 Then
      pZeraMesesSelecionadosMetodo2
    Else
      pZeraMesesSelecionados;

    blnConfirma := fRealizaCalculoGiro(True, intTamMat) And fRealizaCalculoGiro(False, intTamMat);

    {*****************************************}
    {* CASO OCORRA TUDO OK, COMMITA          *}
    {**************************************MV*}
    If blnControlaTransacao Then
    Begin
      If blnConfirma Then
        fCommit
      Else
        fRollBack;
    End;

  Except
    On E: Exception Do
    Begin
      {*****************************************}
      {* CASO OCORRA ALGUM ERRO, CANCELA       *}
      {**************************************MV*}
      pgbProgresso.Position := 0;
      blnConfirma := False;
      If blnControlaTransacao Then
      Begin
        fRollBack;
        pMensagensErro(e.Message,'[fProcessaCadIte]');
      end
      Else
        raise E;
    End;
  End;

  Result := blnConfirma;

end;

procedure TfrmFecGiroEstoque.pPrencheArrMeses;
  Var
    chkTemp: TCheckBox;
    intContador: Integer;
    intTamMat: Integer;
begin
  SetLength(arrMeses, 0);
  For intContador := 1 To 12 Do
  Begin

    chkTemp := (fComponentByName(gpbMeses, 'chkMes' + fStrZero(IntToStr(intContador), 2)) As TCheckBox);

    If chkTemp.Checked Then
    Begin
      intTamMat := Length(arrMeses);
      SetLength(arrMeses, intTamMat+1);
      arrMeses[intTamMat] := intContador;
    End;

  End;
end;

procedure TfrmFecGiroEstoque.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled       := False;
  btnSairFechamento.Enabled := False;
  gpbMeses.Enabled          := False;
  edtAno.Enabled            := False;

  Application.ProcessMessages;
  pnlInfo.Caption := 'Calculando Giro de Estoque, aguarde...';
  Application.ProcessMessages;

  If fProcessaCadIte Then
  Begin

    If fCfgSisL('ATICOM', varBoolean) Then
      pInativaCompraItensSemVendas;

    If (Not blnAutoGiro) And (fEmptyStr(strItemGiro)) Then
      fMensagem('', 'Cálculo do Giro de Estoque concluído com sucesso!', ['&O k']);

    Application.ProcessMessages;
    pnlInfo.Caption := '';
    Application.ProcessMessages;

    Self.Close;

  End
  Else
  Begin

    btnConfirma.Enabled       := True;
    btnSairFechamento.Enabled := True;
    gpbMeses.Enabled          := True;
    edtAno.Enabled            := True;

  End;

end;

procedure TfrmFecGiroEstoque.pCalcularGiroTrocaCodigo;
  Var
    intContador: Integer;
begin
  For intContador := 01 To 12 Do
  Begin
    TCheckBox(fComponentByName(gpbMeses, 'chkMes' + fStrZero(intContador, 2))).Checked := True;
  End;
  Caption := 'Giro do Item ' + strItemGiro + ' para a empresa ' + strEmpGiro;
  btnConfirma.Click;
end;

procedure TfrmFecGiroEstoque.pDesabilitaCheckBox(blnTodos: Boolean);
  Var
    intContador: Integer;
    intMes: Integer;
    chkTemp: TCheckBox;
begin

  If blnTodos Then
    intMes := 0
  Else
    intMes := StrToInt(FormatDateTime('mm', VS_Date));

  For intContador := intMes+1 To 12 Do
  Begin
    chkTemp := (fComponentByName(gpbMeses, 'chkMes' + fStrZero(IntToStr(intContador), 2)) As TCheckBox);
    chkTemp.Visible := False;
    chkTemp.Checked := False;
  End;

end;

procedure TfrmFecGiroEstoque.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaCheckBox;
  pDesabilitaCheckBox(False);

  If blnAutoGiro Then
    Caption := Caption + ' (Empresa ' + VS_strCodEmp + ')';

  blnMetod2 := fCfgSis('METGIR') = '2';

  If blnMetod2 Then
  Begin
    pnlMeses.Visible := False;
    self.Height      := self.Height - pnlMeses.Height;
  End;
end;

function TfrmFecGiroEstoque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strAnoAtu: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtAno) Then
    Begin

      strAnoAtu := FormatDateTime('yyyy', VS_Date);

      If (edtAno.Text = strAnoAtu) Then
      Begin
        pHabilitaCheckBox;
        pDesabilitaCheckBox(False);
      End
      Else If StrToIntDef(edtAno.Text, 0) < 1930 Then
      Begin
        Result := False;
        pDesabilitaCheckBox(True);
      End
      Else If StrToInt(edtAno.Text) < StrToInt(strAnoAtu) Then
      Begin
        pHabilitaCheckBox;
      End
      Else
      Begin
        Result := False;
        pDesabilitaCheckBox(True);
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFecGiroEstoque.pHabilitaCheckBox;
  Var
    intContador: Integer;
    chkTemp: TCheckBox;
begin

  For intContador := 1 To 12 Do
  Begin

    chkTemp := (fComponentByName(gpbMeses, 'chkMes' + fStrZero(IntToStr(intContador), 2)) As TCheckBox);
    chkTemp.Visible := True;
    chkTemp.Checked := True;

  End;

end;


procedure TfrmFecGiroEstoque.pInativaCompraItensSemVendas;
begin
  pCriarForm(TfrmBloqueioProdutos);
end;

procedure TfrmFecGiroEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  blnGerarAutomatico := False;
  blnCalculando := False;
  blnControlaTransacao := True;
end;

procedure TfrmFecGiroEstoque.FormPaint(Sender: TObject);
  Var
    qryGenFec: TUniQuery;
begin
  inherited;

  If (Not fEmptyStr(strItemGiro)) And (Not blnCalculando) Then
  Begin
    blnCalculando := True;
    pCalcularGiroTrocaCodigo;
    tmrClose.Enabled := True;
    Exit;
  End;

  Try
    If blnMetod2 Then
      pPrencheArrPeriodo;

    qryGenFec := fCriaQuery(Self);

    If (blnGerarAutomatico) Then
    Begin

      blnGerarAutomatico := False;
      Application.ProcessMessages;
      btnConfirma.Click;
      FreeAndNil(qryGenFec);
      Close;
      Exit;

    End;

  Except

  End;

 FreeAndNil(qryGenFec);
end;

procedure TfrmFecGiroEstoque.pZeraMesesSelecionados;
  Var
    intContador: Integer;
    strSQL: String;
    qryAux: TUniQuery;
begin

  If Length(arrMeses) <= 0 Then
    Exit;

  qryAux := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  GIRITE ';
  strSQL := strSQL + 'SET ';

  For intContador := Low(arrMeses) To High(arrMeses) Do
  Begin
    strSQL := strSQL + '  GIR_QENT' + fStrZero(arrMeses[intContador], 2) + ' = 0.0, ';
    strSQL := strSQL + '  GIR_QSAI' + fStrZero(arrMeses[intContador], 2) + ' = 0.0 ';
    If intContador < Length(arrMeses)-1 Then
      strSQL := strSQL + ', ';
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   GIR_CODEMP = ' + IIF(fEmptyStr(strEmpGiro), VS_strCodEmp, strEmpGiro) + ' AND ';
  strSQL := strSQL + '   GIR_A_N_O_ = ' + QuotedStr(edtAno.Text);

  If Not fEmptyStr(strItemGiro) Then
   strSQL := strSQL + ' AND GIR_CODITE = ' + QuotedStr(strItemGiro) + ' ';

  qryAux.SQL.Add(strSQL);
  qryAux.ExecSQL;

  FreeAndNil(qryAux);

end;

procedure TfrmFecGiroEstoque.pZeraMesesSelecionadosMetodo2;
  Var
    intContador: Integer;
    strSQL: String;
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Self);

  For intContador := Low(arrPeriodo) To High(arrPeriodo) Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  GIRITE ';
    strSQL := strSQL + 'SET ';

    strSQL := strSQL + '  GIR_QENT' + fStrZero(MonthOf(arrPeriodo[intContador].dtaDtaFin), 2) + ' = 0.0, ';
    strSQL := strSQL + '  GIR_QSAI' + fStrZero(MonthOf(arrPeriodo[intContador].dtaDtaFin), 2) + ' = 0.0 ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   GIR_CODEMP = ' + IIF(fEmptyStr(strEmpGiro), VS_strCodEmp, strEmpGiro) + ' AND ';
    strSQL := strSQL + '   GIR_A_N_O_ = ' + QuotedStr(IntToStr(YearOf(arrPeriodo[intContador].dtaDtaFin)));

    If Not fEmptyStr(strItemGiro) Then
      strSQL := strSQL + ' AND GIR_CODITE = ' + QuotedStr(strItemGiro) + ' ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ExecSQL;
    qryAux.Close;
  End;

  FreeAndNil(qryAux);

end;

procedure TfrmFecGiroEstoque.tmrCloseTimer(Sender: TObject);
begin
  inherited;
  Close;
end;

end.

