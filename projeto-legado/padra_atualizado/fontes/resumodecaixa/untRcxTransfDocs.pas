unit untRcxTransfDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem, MemDS,
  DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, untRcxTResumoDeCaixa;

type
  TfrmRcxTransfDocs = class(TfrmPaiOrdena)
    Label1: TLabel;
    Label2: TLabel;
    edtTotSel: TEditFocus;
    edtTotGer: TEditFocus;
    cdsTotais: TUniClientDataSet;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    blnMarcaTodos: Boolean;

    FAutoIncremsDocumentos: TStringList;

    procedure pAtualizaTotSel;

    procedure CarregaAutoIncremsDocumentos;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    procedure pMascaraValor; Override;
  public
    { Public declarations }

    {************************}
    {* CHA - cheque a vista *}
    {* CHP - cheque pré     *}
    {* CCA - cartão crédito *}
    {*********************LU*}
    strOpcao: String;
    strCodOpe: String;
    strCodGpo: String;

    fltTotSel: Double;
    blnConfirma: Boolean;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;

    property AutoIncremsDocumentos: TStringList read FAutoIncremsDocumentos;
  end;

implementation

uses untFuncoesSimples, StrUtils, System.UITypes, untCadRcxx;

{$R *.dfm}

procedure TfrmRcxTransfDocs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of

    VK_F6    : btnMarcaTodos.Click;
    VK_F7    : btnDesmarcaTodos.Click;
    VK_F10   : Begin
                 btnGravar.Click;
                 Key := 0;
               End;

    VK_RETURN: If cdsConsulta.RecordCount > 0 Then
               Begin
                 If cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
                 Begin
                   cdsConsulta.Edit;
                   cdsConsulta.FieldByName('MARDES').AsString := 'D';
                   cdsConsulta.Post;
                   pAtualizaTotSel;
                 End
                 Else
                 Begin
                   cdsConsulta.Edit;
                   cdsConsulta.FieldByName('MARDES').AsString := 'M';
                   cdsConsulta.Post;
                   pAtualizaTotSel;
                 End;
               End;

    VK_ESCAPE: If cdsConsulta.State = dsEdit Then
                 cdsConsulta.Cancel
               Else
                 Close;

    Else       inherited;

  End;
end;

procedure TfrmRcxTransfDocs.btnMarcaTodosClick(Sender: TObject);
Var
  intRecNo: Integer;
begin
  btnGravar.Enabled := False;
  inherited;

  cdsConsulta.DisableControls;
  intRecNo := cdsConsulta.RecNo;

  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    Application.ProcessMessages;
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARDES').AsString := 'M';
    cdsConsulta.Post;

    cdsConsulta.Next;
  End;
  pAtualizaTotSel;

  cdsConsulta.RecNo := intRecNo;
  cdsConsulta.EnableControls;

  btnGravar.Enabled := True;
end;

procedure TfrmRcxTransfDocs.CarregaAutoIncremsDocumentos;
  Var
    LConsulta: TUniQuery;
begin
    cdsConsulta.DisableControls;

    cdsConsulta.First;

    LConsulta := fCriaQuery;

    Try
      While Not cdsConsulta.Eof Do
      Begin
        If Not cdsConsulta.FieldByName('MARDES').AsString.Equals('M') Then
        Begin
          cdsConsulta.Next;
          Continue;
        End;

        If strOpcao.Equals('CCA') Then
        Begin
          LConsulta.Close;

          LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                                'FROM MOVCAR ' +
                                'WHERE MCA_SEQCON=:SEQCON ' +
                                '  AND MCA_DTACAD=:DTACAD ' +
                                '  AND MCA_EMPRCX=:EMPRCX ' +
                                '  AND MCA_CODCLI=:CODCLI ' +
                                '  AND MCA_NUMDUP=:NUMDUP ';

          LConsulta.ParamByName('SEQCON').AsInteger := cdsConsulta.FieldByName('SEQCON').AsInteger;
          LConsulta.ParamByName('DTACAD').AsDateTime := cdsConsulta.FieldByName('DTACAD').AsDateTime;
          LConsulta.ParamByName('EMPRCX').AsString := VS_strCodEmp;
          LConsulta.ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('CODCLI').AsString;
          LConsulta.ParamByName('NUMDUP').AsString := cdsConsulta.FieldByName('AGENCIA').AsString;

          LConsulta.Open;

          While Not LConsulta.Eof Do
          Begin
            FAutoIncremsDocumentos.Add(LConsulta.FieldByname('AUTOINCREM').AsString);

            LConsulta.Next;
          End;
        End
        Else If MatchStr(strOpcao, ['CHA', 'CHP']) Then
          FAutoIncremsDocumentos.Add(cdsConsulta.FieldByname('AUTOINCREM').AsString);

        cdsConsulta.Next;
      End;
    Finally
      LConsulta.Close;
      FreeAndNil(LConsulta);

      cdsConsulta.First;
      cdsConsulta.EnableControls;
    End;
end;

procedure TfrmRcxTransfDocs.btnDesmarcaTodosClick(Sender: TObject);
Var
  intRecNo: Integer;
begin
  btnGravar.Enabled := False;
  inherited;

  cdsConsulta.DisableControls;
  intRecNo := cdsConsulta.RecNo;

  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    Application.ProcessMessages;
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARDES').AsString := 'D';
    cdsConsulta.Post;

    cdsConsulta.Next;
  End;
  pAtualizaTotSel;

  cdsConsulta.RecNo := intRecNo;
  cdsConsulta.EnableControls;

  btnGravar.Enabled := True;
end;

function TfrmRcxTransfDocs.fGetSql(blnLike: Boolean): String;
Var
  strSQL: String;

  LDataDoCaixa: TDateTime;
Begin
  objResumoDeCaixa.fNecessitaFecharCaixa(False, LDataDoCaixa, strCodigoCaixa, False);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If MatchStr(strOpcao, ['CHA', 'CHP']) Then
  Begin
    strSQL := strSQL + '  C.AUTOINCREM, ';
    strSQL := strSQL + '  CHQ_CODBCO AS BANCO, ';
    strSQL := strSQL + '  CHQ_NUMAGE AS AGENCIA, ';
    strSQL := strSQL + '  CHQ_CONCOR AS CONTA,  ';
    strSQL := strSQL + '  CHQ_NUMCHQ AS NUMERO, ';
    strSQL := strSQL + '  CHQ_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CHQ_NOMEMI AS NOMEMI, ';
    strSQL := strSQL + '  CHQ_VALCHQ AS VALOR,  ';
    strSQL := strSQL + '  CHQ_DTACAD AS DTACAD, ';
    strSQL := strSQL + '  CHQ_DTAVEN AS DTAVEN, ';
    strSQL := strSQL + '  DATEDIFF(CHQ_DTAVEN, CHQ_DTACAD) AS QTDDIA, ';
    strSQL := strSQL + '  "CADCHQ"   AS NOMTBL, ';
    strSQL := strSQL + '  "D" AS MARDES,        ';
    strSQL := strSQL + '  0          AS QTDPAR, ';
    strSQL := strSQL + '  RCX_SEQCON AS SEQCON, ';
    strSQL := strSQL + '  RCX_CODOPE            ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ C ';
    strSQL := strSQL + '  JOIN CADRCXX ';
    strSQL := strSQL + '    ON RCX_SEQCON = CHQ_SEQCON ';
    strSQL := strSQL + '    AND RCX_CODEMP = CHQ_EMPRCX ';

    If Not fEmptyStr(strCodGpo) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(strCodGpo);

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_RESCAI = "1" AND ';
    strSQL := strSQL + '  CHQ_EMPRCX = ' + QuotedStr(VS_strCodEmp) + ' AND ';
    If (strOpcao = 'CHA') Then
      strSQL := strSQL + '  CHQ_DTACAD = CHQ_DTAVEN AND '
    Else
      strSQL := strSQL + '  CHQ_DTACAD <> CHQ_DTAVEN AND ';
    strSQL := strSQL + '  CHQ_DTADEV IS NULL AND ';
    strSQL := strSQL + '  CHQ_DTADEP IS NULL AND ';
    strSQL := strSQL + '  CHQ_DTATRA IS NULL AND ';
    strSQL := strSQL + '  CHQ_SEQCON <> 0 ';

    If Not strCodigoCaixa.IsEmpty Then
      strSQL := strSQL + ' AND CHQ_CODCAX = ' + strCodigoCaixa.QuotedString;

    If Not fEmptyStr(strCodOpe) Then
      strSQL := strSQL + ' AND RCX_CODOPE = ' + QuotedStr(strCodOpe);

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '   RCX_SEQCON, CHQ_NUMAGE, CHQ_CONCOR, CHQ_NUMCHQ, CHQ_CODCLI ';
    strSQL := strSQL + ' ORDER BY DTACAD, CODCLI ';
  End
  Else
  Begin
    strSQL := strSQL + '  MOVCAR.AUTOINCREM, ';
    strSQL := strSQL + '  CAR_DESCAR AS BANCO, ';
    strSQL := strSQL + '  MCA_NUMDUP AS AGENCIA, ';
    strSQL := strSQL + '  COUNT(*)   AS CONTA,  ';
    strSQL := strSQL + '  MCA_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMEMI, ';
    strSQL := strSQL + '  SUM(MCA_VALSTA) AS VALOR, ';
    strSQL := strSQL + '  MCA_DTACAD AS DTACAD, ';
    strSQL := strSQL + '  MCA_DTAVEN AS DTAVEN, ';
    strSQL := strSQL + '  MCA_CODCAR AS CODCAR, ';
    strSQL := strSQL + '  MCA_NUMCCD AS NUMCCD, ';
    strSQL := strSQL + '  MCA_NUMNSU AS NUMNSU, ';
    strSQL := strSQL + '  0          AS QTDDIA, ';
    strSQL := strSQL + '  "MOVCAR"   AS NOMTBL, ';
    strSQL := strSQL + '  "D" AS MARDES, ';
    strSQL := strSQL + '  MCA_DOCUME AS DOCUME, ';
    strSQL := strSQL + '  CAR_TIPCAR AS TIPCAR, '; //MF: 295418 - 07/08/23
    strSQL := strSQL + '  MCA_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  MCA_SEQCON AS SEQCON, ';

    strSQL := strSQL + '  ( ';
    strSQL := strSQL + '    SELECT ';
    strSQL := strSQL + '      RCX_CODOPE ';
    strSQL := strSQL + '    FROM ';
    strSQL := strSQL + '      CADRCXX ';

    If Not fEmptyStr(strCodGpo) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(strCodGpo);

    strSQL := strSQL + '    WHERE ';
    strSQL := strSQL + '      RCX_SEQCON = MCA_SEQCON AND ';
    strSQL := strSQL + '      RCX_CODEMP = MCA_EMPRCX AND ';

    If Not strCodigoCaixa.IsEmpty Then
      strSQL := strSQL + ' RCX_CODCAX = ' + strCodigoCaixa.QuotedString + ' AND ';

    strSQL := strSQL + '      RCX_CARREC <> 0 ';
    strSQL := strSQL + '    ORDER BY RCX_DTACAD DESC LIMIT 1 ';
    strSQL := strSQL + '  ) AS RCX_CODOPE, ';

    strSQL := strSQL + '  ( ';
    strSQL := strSQL + '    SELECT ';
    strSQL := strSQL + '      COUNT(*) ';
    strSQL := strSQL + '    FROM ';
    strSQL := strSQL + '      CADRCXX ';

    If Not fEmptyStr(strCodGpo) Then
      strSQL := strSQL + '  JOIN OPEGPO ON RCX_CODOPE = OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(strCodGpo);

    strSQL := strSQL + '    WHERE ';
    strSQL := strSQL + '      RCX_SEQCON = MCA_SEQCON AND ';
    strSQL := strSQL + '      RCX_CODEMP = MCA_EMPRCX AND ';

    If Not strCodigoCaixa.IsEmpty Then
      strSQL := strSQL + ' RCX_CODCAX = ' + strCodigoCaixa.QuotedString + ' AND ';

    strSQL := strSQL + '      RCX_CARREC <> 0 ';
    strSQL := strSQL + '  ) AS VALRCX ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCAR ';
    strSQL := strSQL + '  JOIN CADCAR ON (MCA_CODCAR=CAR_CODCAR) ';
    strSQL := strSQL + '  JOIN CADCLI ON (MCA_CODCLI=CLI_CODCLI) ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MCA_RESCAI = 1     AND ';
    strSQL := strSQL + '  MCA_DTATRA IS NULL AND ';
    strSQL := strSQL + '  MCA_EMPRCX = "' + VS_strCodEmp + '" AND ';
    strSQL := strSQL + '  (MCA_DTAREC IS NULL OR MCA_DTACAD>="' + FormatDateTime('yyyy-mm-dd', LDataDoCaixa) + '") AND ';
    strSQL := strSQL + '  MCA_SEQCON <> 0 ';

    If Not strCodigoCaixa.IsEmpty Then
      strSQL := strSQL + ' AND MCA_CODCAX = ' + strCodigoCaixa.QuotedString;

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '   MCA_SEQCON, MCA_NUMDUP, MCA_CODCLI, MCA_CODEMP ';

    strSQL := strSQL + 'HAVING  ';
    strSQL := strSQL + '  VALRCX > 0 ';

    If Not fEmptyStr(strCodOpe) Then
      strSQL := strSQL + ' AND RCX_CODOPE = ' + QuotedStr(strCodOpe);

    strSQL := strSQL + ' ORDER BY DTACAD, CODCLI ';
  End;

  Result := strSQL;
End;

function TfrmRcxTransfDocs.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Result := false;

  If cdsConsulta.IsEmpty Then
    Result := inherited fAbreConsulta(blnLike);

  If Result Then
  Begin
    (cdsConsulta.FieldByName('VALOR') As TFloatField).DisplayFormat := '####0.00';

    If strOpcao = 'CCA' Then
    Begin
      dbgConsulta.Columns[0].Title.Caption := 'Cartão';
      dbgConsulta.Columns[1].Title.Caption := 'Documento';
      dbgConsulta.Columns[2].Title.Caption := 'Parcelas';

      dbgConsulta.Columns[3].Visible := False;

      dbgConsulta.Columns[0].Width := 125;
      dbgConsulta.Columns[1].Width := 60;
      dbgConsulta.Columns[2].Width := 47;

      With dbgConsulta.Columns.Add Do
      Begin
        FieldName     := 'NUMCCD';
        Title.Caption := 'Núm. Liberação';
        Width         := 110;
      End;

      With dbgConsulta.Columns.Add Do
      Begin
        FieldName     := 'NUMNSU';
        Title.Caption := 'Núm. NSU';
        Width         := 110;
      End;

      With dbgConsulta.Columns.Add Do
      Begin
        FieldName     := 'DOCUME';
        Title.Caption := 'Documento';
        Width         := 200;
      End;
    End
    Else
    Begin
      dbgConsulta.Columns[0].Title.Caption := 'Banco';
      dbgConsulta.Columns[1].Title.Caption := 'Agência';
      dbgConsulta.Columns[2].Title.Caption := 'Nº Conta';
      dbgConsulta.Columns[0].Width := 34;
      dbgConsulta.Columns[1].Width := 60;
      dbgConsulta.Columns[2].Width := 65;
      dbgConsulta.Columns[3].Width := 65;
    End;

  End;

  blnMarcaTodos := FALSE;
End;

procedure TfrmRcxTransfDocs.FormShow(Sender: TObject);
begin
  inherited;
  fAbreConsulta(TRUE);

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOTGER';
    FieldName     := 'TOTGER';
    DataSet       := cdsTotais;
    Expression    := 'SUM(VALOR)';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOTSEL';
    FieldName     := 'TOTSEL';
    DataSet       := cdsTotais;
    Expression    := 'SUM(VALOR)';
    Active        := True;
  End;

  cdsTotais.Data := cdsConsulta.Data;
  cdsTotais.Filtered := False;

  If Not cdsTotais.IsEmpty Then
    edtTotGer.Text := FormatFloat('#####0.00', TAggregateField(cdsTotais.FieldByName('TOTGER')).Value)
  Else
    edtTotGer.Text := '0,00';
end;

procedure TfrmRcxTransfDocs.FormCreate(Sender: TObject);
begin
  inherited;
  blnMarcaTodos  := False;
  blnSempreRelerBanco := False;
  blnConfirma := False;

  strCodigoCaixa := '';

  FAutoIncremsDocumentos := TStringList.Create;
end;

procedure TfrmRcxTransfDocs.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FAutoIncremsDocumentos);
end;

procedure TfrmRcxTransfDocs.btnGravarClick(Sender: TObject);
var
  strCampoAnl: String;
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    fltTotSel := fStrToFloat(edtTotSel.Text);

    If (fCfgSis('RCXTCC', varString) = '2') Then
    Begin
      strCampoAnl := '';
      If (strOpcao = 'CHA') Then
        strCampoAnl := 'RCX_CHQAVI';

      If (strOpcao = 'CHP') Then
        strCampoAnl := 'RCX_CHQPRE';

      If (strOpcao = 'CCA') Then
        strCampoAnl := 'RCX_CARREC';

      If (Round(fltTotSel * 100) > Round(objResumoDeCaixa.fRetornaSaldoCaixaCampo(strCampoAnl, strCodigoCaixa) * 100)) Then
      Begin
        pMensagemOk('Foram selecionados valores maiores que o saldo disponível para transferência. ' +
                    'Favor verificar novamente se os valores selecionados constam no saldo do caixa. ' +
                    'Caso o problema persista, entrar em contato com a Citel.');
        Exit;
      End;

      CarregaAutoIncremsDocumentos;
    End;

    blnConfirma := True;
    Self.Close;
  End;
end;

procedure TfrmRcxTransfDocs.pMascaraValor;
Begin
//
End;

procedure TfrmRcxTransfDocs.pAtualizaTotSel;
Begin
  cdsTotais.Data := cdsConsulta.Data;
  cdsTotais.Filtered := True;

  If Not cdsTotais.IsEmpty Then
    edtTotSel.Text := FormatFloat('#####0.00', TAggregateField(cdsTotais.FieldByName('TOTSEL')).Value)
  Else
    edtTotSel.Text := '0,00';

End;

procedure TfrmRcxTransfDocs.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
//  inherited;
  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgConsulta.Canvas.Brush.Color:= clInfoBk;
    dbgConsulta.Canvas.Font.Color:= clWindowText;
    dbgConsulta.Canvas.FillRect(Rect);
  End;

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
    Begin
      If Brush.Color = clHighLight Then
        Font.Color := clHighLightText
      Else
        Brush.Color := clAqua;
    End;
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmRcxTransfDocs.dbgConsultaDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
//  inherited;
  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
    Begin
      If Brush.Color = clHighLight Then
        Font.Color := clHighLightText
      Else
        Brush.Color := clAqua;
    End;
  End;
  dbgConsulta.DefaultDrawDataCell(Rect,Field,State);
end;

procedure TfrmRcxTransfDocs.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.RecordCount > 0 Then
  Begin
    If cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARDES').AsString := 'D';
      cdsConsulta.Post;
      pAtualizaTotSel;
    End
    Else
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARDES').AsString := 'M';
      cdsConsulta.Post;
      pAtualizaTotSel;
    End;
  End;

end;

end.
