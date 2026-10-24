unit untRelFatMapDemonsEstoq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, Uni, AppEvnts, UniClientDataSet, DirectoryEditFocus, CheckLst,
  DateUtils, BitBtnLockedIncrem, DB, ComCtrls, untTypesSistema,
  frxExportCSVTestabilidade;

type
  TfrmRelFatMapDemonsEstoq = class(TfrmPaiRelatorio)
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label3: TLabel;
    frxRelJ: TfrxReport;
    mskLinGru: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    pgbProgresso: TProgressBar;
    Label11: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    rdgLitUni: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    strLinGru,
    strCodEmp: String;

    arrCodEmp,
    arrLinGru: TConsultasArray;


    procedure pCalcSaldoInicialItens(Var fltSaldoIni: Double;
                                         dtaDtaBal,
                                         dtaDtaIni: TDateTime;
                                         strCodIte: String;
                                         strCodEmp: String);
                                         
    procedure pCalculaSaldoAnterior(Var cdsDados: TUniClientDataSet);

    procedure pAgrupaItens(cdsItens, cdsItensGrupo: TUniClientDataSet);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorEnter: Boolean): Boolean; Override;
  end;

var
  frmRelFatMapDemonsEstoq: TfrmRelFatMapDemonsEstoq;

implementation

uses StrUtils, untConstantes, untConsultas, Math, untModulo, untIZClient, untIFuncoes,
     untFuncoesSimples, untFuncoes, untCfgRel, untFuncoesRelatorios, untFuncoesConsulta,
  untZClient;

{$R *.dfm}

procedure TfrmRelFatMapDemonsEstoq.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If ((ActiveControl) = Nil) Or (SameText(ActiveControl.ClassName, 'TGroupButton')) Then
    SelectNext(ActiveControl, True, True);

  Case Key Of
    VK_RETURN: If ActiveControl Is TComboBox Then
                  SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatMapDemonsEstoq.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  rdgLitUni.ItemIndex := 1;

end;

procedure TfrmRelFatMapDemonsEstoq.pAgrupaItens(cdsItens, cdsItensGrupo: TUniClientDataSet);
Begin

  cdsItensGrupo.EmptyDataSet;
  With cdsItens Do
  Begin
    pgbProgresso.Max := RecordCount;
    pgbProgresso.Position:= 0;
    pgbProgresso.Visible := True;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin

      If Not cdsItensGrupo.Locate('CODGRU', FieldByName('CODGRU').AsString, []) Then
      Begin
        cdsItensGrupo.Insert;

        cdsItensGrupo.FieldByName('CODGRU').AsString := FieldByName('CODGRU').AsString;
        cdsItensGrupo.FieldByName('DESGRU').AsString := FieldByName('DESGRU').AsString;

        cdsItensGrupo.FieldByName('SALINV').AsFloat  := 0;
        cdsItensGrupo.FieldByName('SALDOS').AsFloat  := 0;
        cdsItensGrupo.FieldByName('QTDVEN').AsFloat  := 0;
        cdsItensGrupo.FieldByName('QTDOUS').AsFloat  := 0;
        cdsItensGrupo.FieldByName('QTDCOM').AsFloat  := 0;
        cdsItensGrupo.FieldByName('QTDOUE').AsFloat  := 0;
        cdsItensGrupo.FieldByName('QTDCON').AsFloat  := 0;
        cdsItensGrupo.FieldByName('SALFIN').AsFloat  := 0;
        cdsItensGrupo.FieldByName('SALANT').AsFloat  := 0;
        cdsItensGrupo.FieldByName('DIFSAL').AsFloat  := 0;

      End Else
      Begin
        cdsItensGrupo.Edit;
      End;

      cdsItensGrupo.FieldByName('SALINV').AsFloat  := cdsItensGrupo.FieldByName('SALINV').AsFloat + FieldByName('SALINV').AsFloat;
      cdsItensGrupo.FieldByName('SALDOS').AsFloat  := cdsItensGrupo.FieldByName('SALDOS').AsFloat + FieldByName('SALDOS').AsFloat;
      cdsItensGrupo.FieldByName('QTDVEN').AsFloat  := cdsItensGrupo.FieldByName('QTDVEN').AsFloat + FieldByName('QTDVEN').AsFloat;
      cdsItensGrupo.FieldByName('QTDOUS').AsFloat  := cdsItensGrupo.FieldByName('QTDOUS').AsFloat + FieldByName('QTDOUS').AsFloat;
      cdsItensGrupo.FieldByName('QTDCOM').AsFloat  := cdsItensGrupo.FieldByName('QTDCOM').AsFloat + FieldByName('QTDCOM').AsFloat;
      cdsItensGrupo.FieldByName('QTDOUE').AsFloat  := cdsItensGrupo.FieldByName('QTDOUE').AsFloat + FieldByName('QTDOUE').AsFloat;
      cdsItensGrupo.FieldByName('QTDCON').AsFloat  := cdsItensGrupo.FieldByName('QTDCON').AsFloat + FieldByName('QTDCON').AsFloat;
      cdsItensGrupo.FieldByName('SALFIN').AsFloat  := cdsItensGrupo.FieldByName('SALFIN').AsFloat + FieldByName('SALFIN').AsFloat;
      cdsItensGrupo.FieldByName('SALANT').AsFloat  := cdsItensGrupo.FieldByName('SALANT').AsFloat + FieldByName('SALANT').AsFloat;
      cdsItensGrupo.FieldByName('DIFSAL').AsFloat  := cdsItensGrupo.FieldByName('DIFSAL').AsFloat + FieldByName('DIFSAL').AsFloat;

      cdsItensGrupo.Post;
      Next;

      pgbProgresso.StepBy(1);
      Application.ProcessMessages;
    End; {While}
  End;

  pgbProgresso.Visible := False;
End;

procedure TfrmRelFatMapDemonsEstoq.btnImprimirClick(Sender: TObject);
  Var
    strSql     : String;
    strNomImp  : String;
    blnEncontrou: Boolean;
    fltSalIni  : Double;
    qryGen, qryDadosEmp: TUniQuery;
    frxRel: TfrxReport;
    cdsItens: TUniClientDataSet;
    cdsItensGrupo: IZClient;

  function fGetSqlItens(strCodIte: String; blnPorGrupo: Boolean = False): String;
  begin
    Result := ' /* TfrmRelFiscMovEstoqContabil.fGetSqlItens */';
    Result := Result + '  SELECT SQL_NO_CACHE       ';
    Result := Result + '    G.GRU_CODGRU AS CODGRU, ';
    Result := Result + '    CONCAT(G.GRU_CODGRU, "-", G.GRU_DESGRU) AS DESGRU, ';
    Result := Result + '    SUM(I.ITE_SALDOS _LITRAGEM_) AS SALINV, ';
    Result := Result + '    SUM(I.ITE_SALDOS _LITRAGEM_) AS SALDOS, ';
    Result := Result + '    0.00 AS QTDVEN,         ';
    Result := Result + '    0.00 AS QTDOUS,         ';
    Result := Result + '    0.00 AS QTDCOM,         ';
    Result := Result + '    0.00 AS QTDOUE,         ';
    Result := Result + '    0.00 AS QTDCON,         ';
    Result := Result + '    IF(:DTAINI < DATE_ADD(I.ITE_DTABAL,INTERVAL 1 DAY), 0, SUM(I.ITE_SALBAL _LITRAGEM_)) AS SALFIN,  ';
    Result := Result + '    IF(:DTAINI < DATE_ADD(I.ITE_DTABAL,INTERVAL 1 DAY), 0, SUM(I.ITE_SALBAL _LITRAGEM_)) AS SALANT,  ';
    Result := Result + '    IF(:DTAINI < DATE_ADD(I.ITE_DTABAL,INTERVAL 1 DAY), 0, SUM(I.ITE_SALBAL _LITRAGEM_)) - (ITE_SALDOS _LITRAGEM_) AS DIFSAL, ';
    Result := Result + '    I.ITE_DTABAL AS DTABAL,                        ';
    Result := Result + '    I.ITE_CODITE AS CODITE,                        ';
    Result := Result + '    SUM(I.ITE_SALBAL _LITRAGEM_) AS SALBAL         ';
    Result := Result + '  FROM                                             ';
    Result := Result + '    CADITE C                                       ';
    Result := Result + '    JOIN ITEGER I ON (I.ITE_CODITE = C.ITE_CODITE) ';
    Result := Result + '    JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI) ';
    Result := Result + '    JOIN CADGRU G ON (G.GRU_CODGRU = C.ITE_CODGRU) ';

    Result := Result + '  WHERE ';

    If blnPorGrupo Then
    Begin
      Result := Result + '  FALSE ';
    End Else
    Begin
      Result := Result + '    I.ITE_CODEMP = :CODEMP ';

      Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'C.ITE_CODGRU', 'CODGRU');

      If Not fEmptyStr(strCodIte) Then
        Result := Result + ' AND C.ITE_CODITE = ' + QuotedStr(strCodIte);


    End;

    Result := AnsiReplaceStr(Result, '_LITRAGEM_', IfThen(rdgLitUni.ItemIndex = 0, '* U.UNI_PESLIT / :LITGAL', ''));
    Result := Result + ' GROUP BY C.ITE_CODITE';

  end;

  procedure pAdicionaItemNovo(strCodIte: String);
    Var
      qryItem : TUniQuery;
      fldCampo: TField;
      intIndex: Integer;
  begin
    qryItem := fCriaQuery(nil);

    With qryItem, SQL Do
    Begin
      Clear;
      Add(fGetSqlItens(strCodIte));
      Open;

      If Not IsEmpty Then
      Begin
        cdsItens.Append;

        For intIndex := 0 To Fields.Count -1 Do
        Begin
          fldCampo := cdsItens.FindField(Fields[intIndex].FieldName);
          If Assigned(fldCampo) Then
            fldCampo.Value := Fields[intIndex].Value;
        End;

        cdsItens.Post;
      End;

    end;

    FreeAndNil(qryItem);
  end;

begin
  pCarregaConfImprRel(Self.Name, strNomImp, strTipImp);

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    cdsItensGrupo:=untZClient.TZClient.Create(Owner, fGetSqlItens('', True));
    If Not cdsItensGrupo.fAbreClient(True, 'TfrmRelFatMapDemonsEstoq.btnImprimirClick') Then
    Begin
      FreeAndNil(cdsItensGrupo);
      Exit;
    End;

    qryGen := fCriaQuery(Nil);

    With qryGen, SQL Do
    Begin
      Close;
      Clear;
      Add(fGetSqlItens(''));

      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryGen);
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp ,'CODEMP', qryGen);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      If rdgLitUni.ItemIndex = 0 Then
        ParamByName('LITGAL').Value := IfThen(fCfgSis('LITGAL') = 'L', 1, FLT_LITRO_GALAO);

      Open;
      cdsItens := fCriaClientDatset(qryGen);
      Close;
    End;

    strSql := ' /* TfrmRelFiscMovEstoqContabil.btnImprimirClick */';
    strSql := strSql + '  SELECT SQL_NO_CACHE       ';
    strSql := strSql + '    G.GRU_CODGRU AS CODGRU, ';
    strSql := strSql + '    CONCAT(G.GRU_CODGRU, "-", G.GRU_DESGRU) AS DESGRU, ';
    strSql := strSql + '    I.ITE_SALBAL _LITRAGEM_ AS SALBAL, ';
    strSql := strSql + '    I.ITE_DTABAL AS DTABAL, ';
    strSql := strSql + '    I.ITE_CODITE AS CODITE, ';
    strSql := strSql + '    SUM(IF((LEFT(DET_CLAFIS,1) >= 5) AND (LOCATE(DET_CLAFIS, :CLAVEN) > 0) AND (DET_DTAENT > ITE_DTABAL), DET_QTDITE _LITRAGEM_, 0)) AS QTDVEN, ';
    strSql := strSql + '    SUM(IF((LEFT(DET_CLAFIS,1) >= 5) AND (LOCATE(DET_CLAFIS, :CLAVEN) = 0) AND (LOCATE(DET_CLAFIS, :CLACON) = 0) AND (DET_DTAENT > ITE_DTABAL), DET_QTDITE _LITRAGEM_, 0)) AS QTDOUS, ';
    strSql := strSql + '    SUM(IF((LEFT(DET_CLAFIS,1) <  5) AND (LOCATE(DET_CLAFIS, :CLACOM) > 0) AND (DET_DTAENT > ITE_DTABAL), DET_QTDITE _LITRAGEM_, 0)) AS QTDCOM,  ';
    strSql := strSql + '    SUM(IF((LEFT(DET_CLAFIS,1) <  5) AND (LOCATE(DET_CLAFIS, :CLACOM) = 0) AND (DET_DTAENT > ITE_DTABAL), DET_QTDITE _LITRAGEM_, 0)) AS QTDOUE,  ';
    strSql := strSql + '    SUM(IF((LEFT(DET_CLAFIS,1) <  5) AND (RIGHT(DET_CLAFIS, 3) = :CLACON) AND (DET_DTAENT > ITE_DTABAL), DET_QTDITE _LITRAGEM_, 0)) AS QTDCON  ';
    strSql := strSql + '  FROM                                               ';
    strSql := strSql + '    MOVDET                                           ';
    strSql := strSql + '    JOIN CADITE C ON C.ITE_CODITE = DET_CODITE       ';
    strSql := strSql + '    JOIN CADGRU G ON G.GRU_CODGRU = C.ITE_CODGRU     ';
    If rdgLitUni.ItemIndex = 0 Then
      strSql := strSql + '    JOIN CADUNI U ON U.UNI_CODUNI = DET_UNIDAD   ';

    strSql := strSql + '    JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
    strSql := strSql + '                     I.ITE_CODEMP =   DET_CODEMP     ';

    strSql := strSql + '  WHERE ';
    strSql := strSql + '    DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
    strSql := strSql + fStrLocateLinGru(mskLinGru, arrLinGru, 'C.ITE_CODGRU', 'CODGRU');
    strSql := strSql + '    AND DET_ESPDOC IN ("NF","IF","IV")     ';
    strSql := strSql + '    AND DET_CODEMP = :CODEMP               ';
    strSQL := strSQL + '    AND DET_FILKAR = FALSE ';

    strSql := strSql + '  GROUP BY                          ';
    strSql := strSql + '    C.ITE_CODITE                    ';

    strSql := strSql  + ' UNION ALL ' + AnsiReplaceStr(strSql, 'MOVDET', 'NOTDET');

    strSql := ' SELECT SQL_NO_CACHE      '+
              '   CODGRU,                '+
              '   CODITE,                '+
              '   DESGRU,                '+
              '   SALBAL AS SALBAL,      '+
              '   DTABAL AS DTABAL,      '+
              '   SUM(QTDVEN) AS QTDVEN, '+
              '   SUM(QTDOUS) AS QTDOUS, '+
              '   SUM(QTDCOM) AS QTDCOM, '+
              '   SUM(QTDOUE) AS QTDOUE, '+
              '   SUM(QTDCON) AS QTDCON  '+
              ' FROM                     '+
              '   (' + strSql + ') TMP   '+
              ' GROUP BY                 '+
              '   CODITE                 ';

    strSql := AnsiReplaceStr(strSql, '_LITRAGEM_', IfThen(rdgLitUni.ItemIndex = 0, '* U.UNI_PESLIT / :LITGAL', ''));

    With qryGen, SQL Do
    Begin
      Close;
      Clear;
      Add(strSql);

      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryGen);
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp, 'CODEMP', qryGen);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLACOM').AsString := VS_strClaCom;
      ParamByName('CLACON').AsString := VS_strCla_UC;

      If rdgLitUni.ItemIndex = 0 Then
        ParamByName('LITGAL').Value := IfThen(fCfgSis('LITGAL') = 'L', 1, FLT_LITRO_GALAO);

      Open;
    End;

    pCalculaSaldoAnterior(cdsItens);

    With cdsItens Do
    Begin
      pgbProgresso.Max := qryGen.RecordCount;
      pgbProgresso.Position:= 0;
      pgbProgresso.Visible := True;
      Application.ProcessMessages;

      qryGen.First;
      While Not qryGen.Eof Do
      Begin
        blnEncontrou := Locate('CODITE', qryGen.FieldByName('CODITE').AsString, []);

        If Not blnEncontrou Then
          pAdicionaItemNovo(qryGen.FieldByName('CODITE').AsString);

        If cdsItens.FieldByName('CODITE').AsString = qryGen.FieldByName('CODITE').AsString Then
        Begin
          Edit;

          If Not blnEncontrou Then
            FieldByName('SALINV').AsFloat := 0;

          FieldByName('QTDCOM').AsFloat := qryGen.FieldByName('QTDCOM').AsFloat;
          FieldByName('QTDVEN').AsFloat := qryGen.FieldByName('QTDVEN').AsFloat;

          FieldByName('QTDOUS').AsFloat := qryGen.FieldByName('QTDOUS').AsFloat;
          FieldByName('QTDOUE').AsFloat := qryGen.FieldByName('QTDOUE').AsFloat;
          FieldByName('QTDCON').AsFloat := qryGen.FieldByName('QTDCON').AsFloat;

          If blnEncontrou Then
            fltSalIni := FieldByName('SALANT').AsFloat
          Else If (StrToDate(mskDtaIni.Text) < qryGen.FieldByName('DTABAL').AsDateTime + 1) Then
          Begin
            fltSalIni := 0;
          End
          Else
          Begin
            fltSalIni := qryGen.FieldByName('SALBAL').AsFloat;
            pCalcSaldoInicialItens(fltSalIni,
                                   qryGen.FieldByName('DTABAL').AsDateTime + 1,
                                   StrToDate(mskDtaIni.Text) - 1,
                                   qryGen.FieldByName('CODITE').AsString,
                                   edtCodEmp.Text);
          End;

          FieldByName('SALANT').AsFloat := fltSalIni;

          FieldByName('SALFIN').AsFloat := fltSalIni + FieldByName('QTDCOM').AsFloat -
                                                       FieldByName('QTDVEN').AsFloat;

          FieldByName('DIFSAL').AsFloat := FieldByName('SALDOS').AsFloat -
                                           FieldByName('SALFIN').AsFloat;

          Post;
        End;

        qryGen.Next;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
      End;

      pgbProgresso.Visible := False;
      pAgrupaItens(cdsItens, cdsItensGrupo.fGetUniClientDataset);

      cdsItensGrupo.IndexFieldNames := 'DESGRU;';

      cdsItensGrupo.First;

      If Not IsEmpty Then
      Begin

        frxRelatorio.DataSet := cdsItensGrupo.fGetDataset;
        frxRel := frxRelJ;

        frxRel.DotMatrixReport           := False;
        frxRel.PrintOptions.PrintMode    := pmScale;
        frxRel.PrintOptions.PrintOnSheet := 9; //A4

        frxRel.Script.Variables['DTAINI'] := mskDtaIni.Text;
        frxRel.Script.Variables['DTAFIN'] := mskDtaFin.Text;

        qryDadosEmp := fCriaQuery;
        Try
          qryDadosEmp.SQL.Text := ' SELECT                                   '
                                + '   *                                      '
                                + ' FROM                                     '
                                + '   CADEMP                                 '
                                + '   JOIN CADCID ON CID_CODCID = EMP_CODCID '
                                + ' WHERE                                    '
                                + '   EMP_CODEMP = :CODEMP                   ';

          qryDadosEmp.ParamByName('CODEMP').AsString := edtCodEmp.Text;
          qryDadosEmp.Open;

          frxRel.Script.Variables['ENDERECO'] := qryDadosEmp.FieldByName('EMP_ENDERE').AsString + ', ' + qryDadosEmp.FieldByName('EMP_ENDNUM').AsString + ' - ' + qryDadosEmp.FieldByName('EMP_BAIRRO').AsString;
          frxRel.Script.Variables['CIDADE']   := qryDadosEmp.FieldByName('CID_NOMCID').AsString;
          frxRel.Script.Variables['ESTADO']   := qryDadosEmp.FieldByName('CID_ESTADO').AsString;
          frxRel.Script.Variables['CEP']      := qryDadosEmp.FieldByName('EMP_C_E_P_').AsString;
          frxRel.Script.Variables['FONE']     := qryDadosEmp.FieldByName('EMP_FONE01').AsString;
          frxRel.Script.Variables['CNPJ']     := qryDadosEmp.FieldByName('EMP_C_G_C_').AsString;
        Finally
          FreeAndNil(qryDadosEmp);
        End;

        If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frxRel)
        Else If frxRel.PrepareReport Then
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
      End
      Else
        pTabelaVazia;

    End;

    FreeAndNil(qryGen);
    FreeAndNil(cdsItens);

    SelectFirst;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

function TfrmRelFatMapDemonsEstoq.fValidaCampos(Sender: TWinControl; blnBuscaPorEnter: Boolean): Boolean;
begin

  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorEnter) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'Informe a Data Inicial!', ['&O k']);
        Result := False;
      End Else
      Begin
        mskDtaIni.Text    := DateToStr(StrToDate(mskDtaIni.Text));
        mskDtaFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyDate(mskDtaIni.Text)) Then
      Begin
        If fEmptyDate(mskDtaFin.Text) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End

        Else If (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
        Begin
          fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
          Result := False;
        End
        Else mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));
      End;

    End

    Else If (Sender = mskLinGru) Then
    Begin
      If fEmptyStr(mskLinGru.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha/Grupo deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
        pDesmarcaLista(mskLinGru,arrLinGru,'', 4);
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
        pDesmarcaLista(edtCodEmp,arrCodEmp, '', 3);
    End

    Else If (Sender = edtDestino) Then
    Begin
      If (fEmptyStr(edtDestino.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O destino deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O destino deve ser V, I ou E!', ['&O k']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

End;


procedure TfrmRelFatMapDemonsEstoq.edtDestinoExit(Sender: TObject);
begin
  //inherited;
end;

procedure TfrmRelFatMapDemonsEstoq.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrCodEmp, nil, fRetNomeEmpresaSelec,'da Empresa');
end;

procedure TfrmRelFatMapDemonsEstoq.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  // NÃO PODE SER MULTI-SELECAO. NESSA CASO TERIA QUE AGRUPAR POR EMPRESA E ITEM
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, nil, Key, arrCodEmp) Then
  Begin
    fValidaCampos(edtCodEmp,True);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatMapDemonsEstoq.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',4);
end;

procedure TfrmRelFatMapDemonsEstoq.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGrupo, Nil, Key, arrLinGru) Then
  Begin
    If fValidaCampos(mskLinGru, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;
procedure TfrmRelFatMapDemonsEstoq.pCalcSaldoInicialItens(Var fltSaldoIni: Double;
                                                                 dtaDtaBal,
                                                                 dtaDtaIni: TDateTime;
                                                                 strCodIte: String;
                                                                 strCodEmp: String);
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;
Begin
  Try

    qryGenDet := fCriaQuery;

    If dtaDtaIni <> dtaDtaBal Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + ' SUM(IFNULL(IF(LEFT(DET_CLAFIS,1) >= 5, -1, 1) * DET_QTDITE _LITRAGEM_, 0)) AS QTDITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVDET ';
      strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = DET_CODITE ';
      If rdgLitUni.ItemIndex = 0 Then
        strSQL := strSQL + '  JOIN CADUNI U ON UNI_CODUNI = DET_UNIDAD ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  DET_ESPDOC IN ("NF","IF","IV") AND ';
      strSQL := strSQL + '  DET_FILKAR = FALSE AND ';
      strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  DET_CODITE = :CODITE AND ';
      strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

      strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL,'MOVDET','NOTDET');

      strSQL := AnsiReplaceStr(strSQL, '_LITRAGEM_', IfThen(rdgLitUni.ItemIndex = 0, '* U.UNI_PESLIT / :LITGAL', ''));

      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate   := dtaDtaBal;
        ParamByName('DTAFIN').AsDate   := dtaDtaIni;
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          fltSaldoIni := fltSaldoIni + FieldByName('QTDITE').AsFloat;

          Next;
        End;

        Close;
      End;
    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

End;

procedure TfrmRelFatMapDemonsEstoq.pCalculaSaldoAnterior(Var cdsDados: TUniClientDataSet);
  Var
    fltSalIni : Double;
begin
  cdsDados.First;

  While Not cdsDados.Eof Do
  Begin
    If (StrToDate(mskDtaFin.Text) < cdsDados.FieldByName('DTABAL').AsDateTime + 1) Then
    Begin
      fltSalIni := 0;
    End
    Else
    Begin
      fltSalIni := cdsDados.FieldByName('SALBAL').AsFloat;
      pCalcSaldoInicialItens(fltSalIni,
                             cdsDados.FieldByName('DTABAL').AsDateTime + 1,
                             StrToDate(mskDtaIni.Text) - 1,
                             cdsDados.FieldByName('CODITE').AsString,
                             edtCodEmp.Text);
    End;

    cdsDados.Edit;
    cdsDados.FieldByName('SALANT').AsFloat := fltSalIni;
    cdsDados.FieldByName('SALFIN').AsFloat := fltSalIni;
    cdsDados.FieldByName('QTDCOM').AsFloat := 0;
    cdsDados.FieldByName('QTDVEN').AsFloat := 0;
    cdsDados.FieldByName('DIFSAL').AsFloat := cdsDados.FieldByName('SALFIN').AsFloat - cdsDados.FieldByName('SALDOS').AsFloat;
    cdsDados.Post;

    cdsDados.Next;
  End;
end;

end.
