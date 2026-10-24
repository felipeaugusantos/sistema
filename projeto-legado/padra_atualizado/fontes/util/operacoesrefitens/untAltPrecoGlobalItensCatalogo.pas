unit untAltPrecoGlobalItensCatalogo;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, ComCtrls,
  Buttons, ExtCtrls, untfuncoesSimples, DB, StrUtils, Menus, Uni, AppEvnts,
  UniClientDataSet, untFatorPreco, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untZClient, untPreAlt_Trigger;

type
  TfrmAltPrecoGlobalItensCatalogo = class(TfrmPaiSimples)
    pnlBotoesEnt: TPanel;
    dbgItens: TDBGridCitel;
    pgbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    btnVoltar: TBitBtnLocked;
    btnMarcAll: TBitBtnLocked;
    Label1: TLabel;
    btnDesmarcMarcAll: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnMarcAllClick(Sender: TObject);
    procedure btnDesmarcMarcAllClick(Sender: TObject);
  private
    { Private declarations }
    arrCamposGrid: Array Of TCampoGlobal;
    arrDesmarcados: Array Of String;
    strTipAbf: String;

    qryPesIte,
    qryPreAlt: TUniQuery;
    objFatPre: TFatorPreco;
    strAgrupadorPreAlt: string;

    Function fTemMargemNegativa: Boolean;

    Function fTemCadIte: Boolean;
    Function fSQLCadIte: String;

    procedure pIncluiMarNeg(cdsMarNeg: TZClient);

    procedure pAtualizaTabela;
    procedure pMarcaItem(blnMarcar: Boolean);
    procedure pSelecionaItem;

    function fConfirmaItens: Boolean;

  public
    { Public declarations }
    cdsItens: TUniClientDataSet;
    blnConfirma: Boolean;
    procedure pCopiaCamposGrid(arrCampos: Array Of TCampoGlobal);
  end;

var
  frmAltPrecoGlobalItensCatalogo: TfrmAltPrecoGlobalItensCatalogo;

implementation

uses  untPreAlt, untFuncoesAuxiliares, untProdMargemNegativa;

{$R *.dfm}

{ TfrmAltPrecoGlobalItensCatalogo }

procedure TfrmAltPrecoGlobalItensCatalogo.pAtualizaTabela;
  Var
    intContador: Integer;
    intTamMat: Integer;
    fldCampo: TField;
    fldCampoNovo: TField;
begin

  With cdsItens Do
  Begin
    For intContador := 0 To FieldCount - 1 Do
      Fields[intContador].Visible := False;

    FieldByName('ITE_CODITE').DisplayLabel := 'Código';
    FieldByName('ITE_CODITE').Visible := True;
    FieldByName('ITE_REFERE').DisplayLabel := 'Referência';
    FieldByName('ITE_REFERE').Visible := True;
    FieldByName('CAT_DESITE').DisplayLabel := 'Descrição';
    FieldByName('CAT_DESITE').Visible := True;

    IndexFieldNames :=  'CAT_DESITE';

    intTamMat := Length(arrCamposGrid);

    For intContador := 0 To intTamMat -1 Do
    Begin

      If not fEmptyStr(arrCamposGrid[intContador].strNomCam) Then
      Begin
        FieldByName(arrCamposGrid[intContador].strNomCam).DisplayLabel := arrCamposGrid[intContador].strDesAbr;
        FieldByName(arrCamposGrid[intContador].strNomCam).Visible := True;
        FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV').DisplayLabel := arrCamposGrid[intContador].strDesAbr + '(NOVO)';
        FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV').Visible := True;
      End;

      If not fEmptyStr(arrCamposGrid[intContador].strDesAbr) Then
      Begin

        fldCampo     := FieldByName(arrCamposGrid[intContador].strNomCam);
        fldCampoNovo := FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV');

        If (fldCampo.DataType <> ftString) And
           (fldCampo.DataType <> ftDate)   Then
        Begin

          If (Not fEmptyStr(arrCamposGrid[intContador].strMasCam)) Then
          Begin
            If (fldCampo.DataType = ftFloat) Then
            Begin
              (fldCampo As TFloatField).DisplayFormat     := arrCamposGrid[intContador].strMasCam;
              (fldCampoNovo As TFloatField).DisplayFormat := arrCamposGrid[intContador].strMasCam;
            End;
          End;

        End;

      End;

    End;

  End;

end;

procedure TfrmAltPrecoGlobalItensCatalogo.pCopiaCamposGrid(
  arrCampos: array of TCampoGlobal);
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  intTamMat := Length(arrCampos);
  SetLength(arrCamposGrid, intTamMat);

  For intContador := 0 To  intTamMat-1 Do
  Begin
    arrCamposGrid[intContador] := arrCampos[intContador];
  End;
end;

procedure TfrmAltPrecoGlobalItensCatalogo.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaTabela;
end;

procedure TfrmAltPrecoGlobalItensCatalogo.btnMarcAllClick(Sender: TObject);
begin
  inherited;

  btnDesmarcMarcAll.Click;

  cdsItens.DisableControls;
  cdsItens.First;
  while Not(cdsItens.eof) do
  Begin
    pSelecionaItem;
    cdsItens.Next;
  End;
  cdsItens.EnableControls;

end;

procedure TfrmAltPrecoGlobalItensCatalogo.btnVoltarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoGlobalItensCatalogo.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    intContador: Integer;
    blnAchou: Boolean;
begin
  inherited;
  dbgItens.DefaultDrawing := False;

  If Not cdsItens.Active Then
    Exit;

  blnAchou := False;

  For intContador := 0 To Length(arrDesmarcados) -1 Do
  Begin
    If arrDesmarcados[intContador] = cdsItens.FieldByName('CAT_CODITE').AsString Then
    Begin
      blnAchou := True;
      Break;
    End;
  End;

  If Not blnAchou Then
    dbgItens.Canvas.Font.Color := clBlue;

  If Pos('novo', LowerCase(Column.FieldName)) > 0 Then
    Column.Color := clSilver
  Else
    Column.Color := clWhite;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  dbgItens.DefaultDrawing := True;
end;

procedure TfrmAltPrecoGlobalItensCatalogo.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    pSelecionaItem
  Else If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_Escape) Then
    btnVoltar.Click
  Else If (Key = VK_F2) Then
    btnMarcAll.Click
  Else If (Key = VK_F3) Then
    btnDesmarcMarcAll.Click;

end;

procedure TfrmAltPrecoGlobalItensCatalogo.pSelecionaItem;
  Var
    intContador: Integer;
    blnAchou: Boolean;
begin

  blnAchou := False;

  For intContador := 0 To Length(arrDesmarcados) -1 Do
  Begin
    If arrDesmarcados[intContador] = cdsItens.FieldByName('CAT_CODITE').AsString Then
      blnAchou := True;
  End;

  If Not blnAchou Then
    pMarcaItem(False)
  Else
    pMarcaItem(True);
end;

procedure TfrmAltPrecoGlobalItensCatalogo.pMarcaItem(blnMarcar: Boolean);
  Var
    intTamMat: Integer;
    intContador: Integer;
    intPosicao: Integer;
    blnAchou: Boolean;
begin

  blnAchou    := False;
  intPosicao :=  0;
  intTamMat   := Length(arrDesmarcados);

  For intContador := 0 To intTamMat -1 Do
  Begin

    If arrDesmarcados[intContador] = cdsItens.FieldByName('CAT_CODITE').AsString Then
    Begin
      blnAchou := True;
      intPosicao := intContador;
      Break;
    End;

  End;

  If Not blnMarcar Then
  Begin
    If Not blnAchou Then
    Begin
      SetLength(arrDesmarcados, intTamMat+1);
      arrDesmarcados[intTamMat] := cdsItens.FieldByName('CAT_CODITE').AsString;
    End;
  End
  Else
  Begin

    For intContador := intPosicao To intTamMat -2 Do
    Begin
      arrDesmarcados[intContador] := arrDesmarcados[intContador+1];
    End;
    SetLength(arrDesmarcados, intTamMat-1);

  End;

end;

Function TfrmAltPrecoGlobalItensCatalogo.fTemMargemNegativa: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  With cdsItens Do
  For intContador := 1 To Length(VS_strTabPrc) Do
    If (VS_strTabPrc[intContador] = 'S') And (FieldByName('CAT_MARBR' + IntToStr(intContador)).AsFloat < 0) Then
    Begin
      Result := True;
      Exit;
    End;

End;

Function TfrmAltPrecoGlobalItensCatalogo.fSQLCadIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT';

  strSQL := strSQL + '   ITE_CODITE, ';
  strSQL := strSQL + '   ITE_DESITE, ';
  strSQL := strSQL + '   ITE_CODUNI  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '    CADITE ';
  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   ITE_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '   ITE_CODFAB = :CODFAB     ';

  Result := strSQL;
End;

Function TfrmAltPrecoGlobalItensCatalogo.fTemCadIte: Boolean;
Begin
  With qryPesIte Do
  Begin
    Close;

    ParamByName('CODFOR').AsString := cdsItens.FieldByName('CAT_CODFOR').AsString;
    ParamByName('CODFAB').AsString := cdsItens.FieldByName('CAT_CODITE').AsString;

    Open;

    Result := Not IsEmpty;
  End;
End;

procedure TfrmAltPrecoGlobalItensCatalogo.pIncluiMarNeg(cdsMarNeg: TZClient);
  Var
    intCont: Integer;
Begin
  If fTemCadIte Then
  with cdsMarNeg Do
  Begin
    Append;

    FieldByName('ITE_CODITE').AsString := qryPesIte.FieldByName('ITE_CODITE').AsString;
    FieldByName('ITE_DESITE').AsString := '(' + cdsItens.FieldByName('CAT_CODITE').AsString + ') ' + qryPesIte.FieldByName('ITE_DESITE').AsString;
    FieldByName('ITE_CODUNI').AsString := qryPesIte.FieldByName('ITE_CODUNI').AsString;

    FieldByName('ITE_PRECUS').AsFloat  := cdsItens.FieldByName('CAT_PRECUS').AsFloat;

    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      FieldByName('ITE_MARBR' + IntToStr(intCont)).AsFloat := cdsItens.FieldByName('CAT_MARBR' + IntToStr(intCont)).AsFloat;
      FieldByName('ITE_PREVE' + IntToStr(intCont)).AsFloat := cdsItens.FieldByName('CAT_PREVE' + IntToStr(intCont)).AsFloat;
    End;

    Post;
  End;
End;

function TfrmAltPrecoGlobalItensCatalogo.fConfirmaItens: Boolean;
  Var
    strSQL: String;
    strUpdCatIte: String;
    strUpdCadIte: String;
    strUpdIteGer: String;
    stlDesmarcados: TStringList;
    intContador: Integer;
    intTamMat: Integer;

    blnAltCatIte: Boolean;
    blnAltCadIte: Boolean;
    blnAltIteGer: Boolean;

    fldCampo: TField;
    fldCampoNovo: TField;

    strEmpresas: String;

    strUpdDtaAltera: String;

    fltVenAtu,
    fltMarAtu: Array [1..7] Of Double;

    fltComAnt: Double;
    fltComAtu: Double;

    fltCusAnt: Double;
    fltCusAtu: Double;

    fltVe1Ant: Double;
    fltMa1Ant: Double;

    fltVe2Ant: Double;
    fltMa2Ant: Double;

    fltVe3Ant: Double;
    fltMa3Ant: Double;

    fltVe4Ant: Double;
    fltMa4Ant: Double;

    fltVe5Ant: Double;
    fltMa5Ant: Double;

    fltVe6Ant: Double;
    fltMa6Ant: Double;

    fltVe7Ant: Double;
    fltMa7Ant: Double;

    strCodIte: String;
    strCodFor: String;
    strCodGru: String;

    qryGenEmp: TUniQuery;
    qryGenTmp: TUniQuery;
    qryGenUpd: TUniQuery;
    qryIteger: TUniQuery;

    intIndice: Integer;

    strUpdIteGerFim: String;

    cdsMarNeg: TZClient;

begin
  qryGenEmp := fCriaQuery;
  qryGenTmp := fCriaQuery;
  qryGenUpd := fCriaQuery;
  qryIteger := fCriaQuery;
  stlDesmarcados := TStringList.Create;
  Try
    Result := True;

    strEmpresas := fRetEmpresasUsamPrecoMatriz;

    intTamMat := Length(arrDesmarcados);

    For intContador := 0 To intTamMat-1 Do
    Begin
      stlDesMarcados.Add(QuotedStr(arrDesMarcados[intContador]));
    End;

    With cdsItens Do
    Begin
      DisableControls;

      {*****************************************}
      {* SELECIONA SOMENTE ITENS MARCADOS      *}
      {**************************************MV*}
      If (stlDesmarcados.Count > 0) Then
      Begin
        Filtered := False;
        Filter := '';
        Filter := ' NOT ( CAT_CODITE IN (' + stlDesmarcados.CommaText + ') ) ';
        Filtered := True;
      End;

      pgbProgresso.Visible := True;
      pgbProgresso.Max := RecordCount;

      Try
        //****************************************************************
        If fCfgSis('MARNEG', varBoolean) Then
        Begin
          cdsMarNeg := TProdMargemNegativa.fCriaDadosItem('');

          First;
          While Not Eof Do
          Begin
            If fTemMargemNegativa Then
              pIncluiMarNeg(cdsMarNeg);

            pgbProgresso.StepBy(1);
            Application.ProcessMessages;
            Next;
          End;

          If Not cdsMarNeg.IsEmpty Then
            Result := TProdMargemNegativa.fLiberaMargemNegativa(cdsMarNeg, cdsMarNeg, rotAltGlobalCatalogo);

          If Not Result Then
            Exit;

          FreeAndNil(cdsMarNeg);
        End;
        //****************************************************************

        pgbProgresso.position := 0;

        First;
        strAgrupadorPreAlt := '';
        pPreAltDefineVariaveisAltPre(fNow, 'ALTERACAO DE PRECOS POR PRODUTO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
        While Not Eof Do
        Begin

          fltCusAnt := 0.0;
          fltCusAtu := 0.0;
          fltComAnt := 0.0;
          fltComAtu := 0.0;
          fltVe1Ant := 0.0;

          For intIndice := 1 To 7 Do
          Begin
            fltVenAtu[intIndice] := 0.0;
            fltMarAtu[intIndice] := 0.0;
          End;

          fltMa1Ant := 0.0;
          fltVe2Ant := 0.0;
          fltMa2Ant := 0.0;
          fltVe3Ant := 0.0;
          fltMa3Ant := 0.0;
          fltVe4Ant := 0.0;
          fltMa4Ant := 0.0;
          fltVe5Ant := 0.0;
          fltMa5Ant := 0.0;
          fltVe6Ant := 0.0;
          fltMa6Ant := 0.0;
          fltVe7Ant := 0.0;
          fltMa7Ant := 0.0;

          blnAltCatIte := False;
          blnAltCadIte := False;
          blnAltIteGer := False;

          intTamMat := Length(arrCamposGrid);

          strUpdCatIte := '';
          strUpdCatIte := strUpdCatIte + 'UPDATE ';
          strUpdCatIte := strUpdCatIte + '  CATITE ';
          strUpdCatIte := strUpdCatIte + 'SET ';
          {*****************************************}
          {* ATUALIZACAO DO OPERADOR, DATA E HORA  *}
          {* DA ALTERACAO                          *}
          {**************************************AA*}
          strUpdCatIte := strUpdCatIte + 'CAT_OPEALT = :OPEALT, ';
          strUpdCatIte := strUpdCatIte + 'CAT_DTAALT = :DTAALT, ';
          strUpdCatIte := strUpdCatIte + 'CAT_HORALT = :HORALT, ';

          strUpdCadIte := '';
          strUpdCadIte := strUpdCadIte + 'UPDATE ';
          strUpdCadIte := strUpdCadIte + '  CADITE ';
          strUpdCadIte := strUpdCadIte + 'SET ';

          strUpdIteGer := '';
          strUpdIteGer := strUpdIteGer + 'UPDATE ';
          strUpdIteGer := strUpdIteGer + '  ITEGER ';
          strUpdIteGer := strUpdIteGer + 'SET ';
          strUpdIteGer := strUpdIteGer + '  ITE_PREALT = "'+strAgrupadorPreAlt+'", ';

          For intContador := 0 To intTamMat -1 Do
          Begin

            If Not fEmptyStr(arrCamposGrid[intContador].strNomCam) Then
            Begin

              fldCampo     := FieldByName(arrCamposGrid[intContador].strNomCam);
              fldCampoNovo := FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV');

              {*****************************************}
              {* ATRIBUI VALORES PARA VARIAVEIS USADAS *}
              {* NA GRAVAÇÃO DO PREALT                 *}
              {**************************************MV*}
              If arrCamposGrid[intContador].strNomCam = 'CAT_PRECUS' Then
              Begin
                fltCusAnt := fldCampo.AsFloat;
                fltCusAtu := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_PRECOM' Then
              Begin
                fltComAnt := fldCampo.AsFloat;
                fltComAtu := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_PREVE1' Then
              Begin
                fltVe1Ant := fldCampo.AsFloat;
                fltVenAtu[1] := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_MARBR1' Then
              Begin
                fltMa1Ant    := fldCampo.AsFloat;
                fltMarAtu[1] := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_MARBR2' Then
              Begin
                fltMa2Ant    := fldCampo.AsFloat;
                fltMarAtu[2] := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_MARBR3' Then
              Begin
                fltMa3Ant    := fldCampo.AsFloat;
                fltMarAtu[3] := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_MARBR4' Then
              Begin
                fltMa4Ant    := fldCampo.AsFloat;
                fltMarAtu[4] := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_MARBR5' Then
              Begin
                fltMa5Ant    := fldCampo.AsFloat;
                fltMarAtu[5] := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_MARBR6' Then
              Begin
                fltMa6Ant    := fldCampo.AsFloat;
                fltMarAtu[6] := fldCampoNovo.AsFloat;
              End
              Else If arrCamposGrid[intContador].strNomCam = 'CAT_MARBR7' Then
              Begin
                fltMa7Ant    := fldCampo.AsFloat;
                fltMarAtu[7] := fldCampoNovo.AsFloat;
              End;

              If arrCamposGrid[intContador].strNomArq = 'CATITE' tHEN
              Begin

                blnAltCatIte := True;

                strUpdCatIte := strUpdCatIte + fldCampo.FieldName + ' = ';

                If fldCampo.DataType = ftString Then
                  strUpdCatIte := strUpdCatIte + QuotedStr(fldCampoNovo.AsString)
                Else
                  strUpdCatIte := strUpdCatIte + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

                If intContador < intTamMat -1 Then
                  strUpdCatIte := strUpdCatIte + ',';

                If (arrCamposGrid[intContador].strNomCam = 'CAT_PESOIT') Or
                   (arrCamposGrid[intContador].strNomCam = 'CAT_PESLIQ') Or
                   (arrCamposGrid[intContador].strNomCam = 'CAT_EMBALA') Or
                   ((arrCamposGrid[intContador].strNomCam = 'CAT_CODABF') And (strTipAbf = '1')) Then
                Begin
                  blnAltCadIte := True;

                  strUpdCadIte := strUpdCadIte + fldCampo.FieldName + ' = ';

                  If fldCampo.DataType = ftString Then
                    strUpdCadIte := strUpdCadIte + QuotedStr(fldCampoNovo.AsString)
                  Else
                    strUpdCadIte := strUpdCadIte + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

                  If intContador < intTamMat -1 Then
                    strUpdCadIte := strUpdCadIte + ',';
                End
                Else
                Begin
                  blnAltIteGer := True;

                  strUpdIteGer := strUpdIteGer + fldCampo.FieldName + ' = ';

                  If fldCampo.DataType = ftString Then
                    strUpdIteGer := strUpdIteGer + QuotedStr(fldCampoNovo.AsString)
                  Else
                    strUpdIteGer := strUpdIteGer + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

                  If intContador < intTamMat -1 Then
                    strUpdIteGer := strUpdIteGer + ',';
                End;

              End;

            End;

          End;

          {*****************************************}
          {* ATUALIZA CATITE                       *}
          {**************************************LU*}
          If blnAltCatIte Then
          Begin

            If RightStr(strUpdCatIte, 1) = ',' Then
              strUpdCatIte := Copy(strUpdCatIte, 1, Length(strUpdCatIte)-1);

            strUpdCatIte := strUpdCatIte + ' WHERE ';
            strUpdCatIte := strUpdCatIte + '  CAT_CODFAB = :CODITE ';

            qryGenUpd.Close;
            qryGenUpd.SQL.Clear;
            qryGenUpd.SQL.Add(strUpdCatIte);
            qryGenUpd.ParamByName('CODITE').AsString := FieldByName('CAT_CODITE').AsString;
            qryGenUpd.ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
            qryGenUpd.ParamByName('DTAALT').AsDate   := VS_Date;
            qryGenUpd.ParamByName('HORALT').AsTime   := fTime();
            qryGenUpd.ExecSQL;
            qryGenUpd.Close;
          End;

          {*******************************************}
          {* VERIFICA SE VAI ALTERAR O CADITE/ITEGER *}
          {****************************************LU*}
          strSQL := '';
          strSQL := strSQL + ' SELECT ';
          strSQL := strSQL + '   CATITE.*,   ';
          strSQL := strSQL + '   ITE_CODITE, ';
          strSQL := strSQL + '   CAT_CODFOR, ';
          strSQL := strSQL + '   ITE_CODGRU  ';
          strSQL := strSQL + ' FROM ';
          strSQL := strSQL + '   CADITE, ';
          strSQL := strSQL + '   CATITE  ';
          strSQL := strSQL + ' WHERE ';
          strSQL := strSQL + '   ITE_CODFOR = CAT_CODFOR AND ';
          strSQL := strSQL + '   ITE_CODFAB = CAT_CODFAB AND ';
          strSQL := strSQL + '   CAT_CODFAB = :CODFAB    AND ';
          strSQL := strSQL + '   CAT_CODFOR = :CODFOR        ';

          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strSQL);
          qryGenTmp.ParamByName('CODFAB').AsString := FieldByName('CAT_CODITE').AsString;
          qryGenTmp.ParamByName('CODFOR').AsString := FieldByName('CAT_CODFOR').AsString;
          qryGenTmp.Open;

          If Not (qryGenTmp.IsEmpty) Then
          Begin
            strCodIte := qryGenTmp.fieldbyname('ITE_CODITE').AsString;
            strCodFor := qryGenTmp.fieldbyname('CAT_CODFOR').AsString;
            strCodGru := qryGenTmp.fieldbyname('ITE_CODGRU').AsString;

            {*****************************************}
            {* ATUALIZA CADITE                       *}
            {**************************************LU*}
            If blnAltCadIte Then
            Begin
              If RightStr(strUpdCadIte, 1) = ',' Then
                strUpdCadIte := Copy(strUpdCadIte, 1, Length(strUpdCadIte)-1);

              strUpdCadIte := AnsiReplaceStr(strUpdCadIte,'CAT_','ITE_');

              strUpdCadIte := strUpdCadIte + ' WHERE ';
              strUpdCadIte := strUpdCadIte + '  ITE_CODITE = :CODITE AND ';
              strUpdCadIte := strUpdCadIte + '  ITE_CODFOR = :CODFOR AND ';
              strUpdCadIte := strUpdCadIte + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';

              qryGenUpd.Close;
              qryGenUpd.SQL.Clear;
              qryGenUpd.SQL.Add(strUpdCadIte);
              qryGenUpd.ParamByName('CODITE').AsString := strCodIte;
              qryGenUpd.ParamByName('CODFOR').AsString := strCodFor;
              qryGenUpd.ParamByName('CODEMP').AsString := strEmpresas;
              qryGenUpd.ExecSQL;
              qryGenUpd.Close;
            End;

            {*****************************************}
            {* ATUALIZA ITEGER                       *}
            {**************************************LU*}
            If blnAltIteGer Then
            Begin
              {*******************************************************************}
              {* VERIFICA SE FOI ALTERADO O PRECO DE VENDA.                      *}
              {* SE FOI ALTERADO, BUSCA AS MARGENS DOS OUTROS PRECOS E RECALCULA *}
              {****************************************************************LU*}
              strSQL := '';
              strSQL := strSQL + ' SELECT ';
              strSQL := strSQL + '   * ';
              strSQL := strSQL + ' FROM ';
              strSQL := strSQL + '   ITEGER ';
              strSQL := strSQL + ' WHERE ';
              strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
              strSQL := strSQL + '   LOCATE(ITE_CODEMP, :CODEMP) > 0 ';

              qryIteger.Close;
              qryIteger.SQL.Clear;
              qryIteger.SQL.Add(strSQL);
              qryIteger.ParamByName('CODITE').AsString := strCodIte;
              qryIteger.ParamByName('CODEMP').AsString := strEmpresas;
              qryIteger.Open;
              strUpdIteGerFim := strUpdIteGer;

              pPreAltDefineVariaveisAltPre(fNow, 'ALTERACAO GLOBAL DE PRECOS - CATALOGO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

              While Not qryIteger.Eof Do
              Begin
                qryGenUpd.Close;

                qryGenUpd.SQL.Text := fSqlUpdateItegerCatalogo;
                qryGenUpd.ParamByName('DESF01').AsFloat := qryGenTmp.FieldByName('CAT_DESF01').AsFloat;
                qryGenUpd.ParamByName('DESF02').AsFloat := qryGenTmp.FieldByName('CAT_DESF02').AsFloat;
                qryGenUpd.ParamByName('DESF03').AsFloat := qryGenTmp.FieldByName('CAT_DESF03').AsFloat;
                qryGenUpd.ParamByName('DESF04').AsFloat := qryGenTmp.FieldByName('CAT_DESF04').AsFloat;
                qryGenUpd.ParamByName('DESF05').AsFloat := qryGenTmp.FieldByName('CAT_DESF05').AsFloat;
                qryGenUpd.ParamByName('DESF06').AsFloat := qryGenTmp.FieldByName('CAT_DESF06').AsFloat;
                qryGenUpd.ParamByName('SUBFED').AsFloat := qryGenTmp.FieldByName('CAT_SUBFED').AsFloat;
                qryGenUpd.ParamByName('DESADB').AsFloat := qryGenTmp.FieldByName('CAT_DESADB').AsFloat;
                qryGenUpd.ParamByName('VALFRE').AsFloat := qryGenTmp.FieldByName('CAT_VALFRE').AsFloat;
                qryGenUpd.ParamByName('OUTVAL').AsFloat := qryGenTmp.FieldByName('CAT_OUTVAL').AsFloat;
                qryGenUpd.ParamByName('DESOPE').AsFloat := qryGenTmp.FieldByName('CAT_DESOPE').AsFloat;
                qryGenUpd.ParamByName('IMPFED').AsFloat := qryGenTmp.FieldByName('CAT_IMPFED').AsFloat;
                qryGenUpd.ParamByName('PRECOM').AsFloat := qryGenTmp.FieldByName('CAT_PRECOM').AsFloat;
                qryGenUpd.ParamByName('PRECUS').AsFloat := qryGenTmp.FieldByName('CAT_PRECUS').AsFloat;
                qryGenUpd.ParamByName('PREVE1').AsFloat := qryGenTmp.FieldByName('CAT_PREVE1').AsFloat;
                qryGenUpd.ParamByName('PREVE2').AsFloat := qryGenTmp.FieldByName('CAT_PREVE2').AsFloat;
                qryGenUpd.ParamByName('PREVE3').AsFloat := qryGenTmp.FieldByName('CAT_PREVE3').AsFloat;
                qryGenUpd.ParamByName('PREVE4').AsFloat := qryGenTmp.FieldByName('CAT_PREVE4').AsFloat;
                qryGenUpd.ParamByName('PREVE5').AsFloat := qryGenTmp.FieldByName('CAT_PREVE5').AsFloat;
                qryGenUpd.ParamByName('PREVE6').AsFloat := qryGenTmp.FieldByName('CAT_PREVE6').AsFloat;
                qryGenUpd.ParamByName('PREVE7').AsFloat := qryGenTmp.FieldByName('CAT_PREVE7').AsFloat;
                qryGenUpd.ParamByName('ICMSAI').AsFloat := qryGenTmp.FieldByName('CAT_ICMSAI').AsFloat;
                qryGenUpd.ParamByName('IPIENT').AsFloat := qryGenTmp.FieldByName('CAT_IPIENT').AsFloat;
                qryGenUpd.ParamByName('FREENT').AsFloat := qryGenTmp.FieldByName('CAT_FREENT').AsFloat;
                qryGenUpd.ParamByName('ACRFIN').AsFloat := qryGenTmp.FieldByName('CAT_ACRFIN').AsFloat;
                qryGenUpd.ParamByName('COMVAR').AsFloat := qryGenTmp.FieldByName('CAT_COMVAR').AsFloat;
                qryGenUpd.ParamByName('ICMENT').AsFloat := qryGenTmp.FieldByName('CAT_ICMENT').AsFloat;
                qryGenUpd.ParamByName('SUBSTI').AsFloat := qryGenTmp.FieldByName('CAT_SUBSTI').AsFloat;
                qryGenUpd.ParamByName('MARBR1').AsFloat := qryGenTmp.FieldByName('CAT_MARBR1').AsFloat;
                qryGenUpd.ParamByName('MARBR2').AsFloat := qryGenTmp.FieldByName('CAT_MARBR2').AsFloat;
                qryGenUpd.ParamByName('MARBR3').AsFloat := qryGenTmp.FieldByName('CAT_MARBR3').AsFloat;
                qryGenUpd.ParamByName('MARBR4').AsFloat := qryGenTmp.FieldByName('CAT_MARBR4').AsFloat;
                qryGenUpd.ParamByName('MARBR5').AsFloat := qryGenTmp.FieldByName('CAT_MARBR5').AsFloat;
                qryGenUpd.ParamByName('MARBR6').AsFloat := qryGenTmp.FieldByName('CAT_MARBR6').AsFloat;
                qryGenUpd.ParamByName('MARBR7').AsFloat := qryGenTmp.FieldByName('CAT_MARBR7').AsFloat;
                qryGenUpd.ParamByName('PREALT').AsString:= strAgrupadorPreAlt;

                If fEmptyStr(qryGenTmp.FieldByName('CAT_CODABF').AsString) Then
                  qryGenUpd.ParamByName('CODABF').Value:= Null
                Else
                  qryGenUpd.ParamByName('CODABF').AsString := qryGenTmp.FieldByName('CAT_CODABF').AsString;

                qryGenUpd.ParamByName('CODITE').AsString := strCodIte;
                qryGenUpd.ParamByName('CODEMP').AsString := qryIteger.fieldbyname('ITE_CODEMP').AsString;

                qryGenUpd.ExecSQL;
                qryGenUpd.Close;

                {*****************************************}
                {* GRAVA PREALT                          *}
                {**************************************LU*}
                If (Not VS_blnPreAltViaTrigger) Then
                  fGravaPreAlt(strCodIte,
                             fltCusAnt, fltCusAtu,
                             fltVe1Ant, fltVenAtu[1],
                             fltMa1Ant, fltMarAtu[1],
                             fltVe2Ant, fltVenAtu[2],
                             fltMa2Ant, fltMarAtu[2],
                             fltVe3Ant, fltVenAtu[3],
                             fltMa3Ant, fltMarAtu[3],
                             fltVe4Ant, fltVenAtu[4],
                             fltMa4Ant, fltMarAtu[4],
                             fltVe5Ant, fltVenAtu[5],
                             fltMa5Ant, fltMarAtu[5],
                             fltVe6Ant, fltVenAtu[6],
                             fltMa6Ant, fltMarAtu[6],
                             fltVe7Ant, fltVenAtu[7],
                             fltMa7Ant, fltMarAtu[7],
                             fltComAnt, fltComAtu,
                             'ALTERACAO GLOBAL DE PRECOS - CATALOGO',
                             Nil,
                             '',
                             strLoginUsuarioLogado);

                pAtualizaItensGrupoPrecos(strCodIte, 'ALTERACAO GLOBAL DE PRECOS - CATALOGO', strAgrupadorPreAlt);

                qryIteger.Next;

              End; {While Not qryIteger.Eof Do}

            End;

          End;

          {*****************************************}
          {* ATUALIZA ULTIMA ATUALIZAÇÃO DO CADITE *}
          {**************************************PE*}
          strUpdDtaAltera := '';
          strUpdDtaAltera := strUpdDtaAltera + 'UPDATE   ';
          strUpdDtaAltera := strUpdDtaAltera + '  CADITE ';
          strUpdDtaAltera := strUpdDtaAltera + 'SET ';
          strUpdDtaAltera := strUpdDtaAltera + '  ITE_HULALT = :HULALT, ';
          strUpdDtaAltera := strUpdDtaAltera + '  ITE_DTAALT = :DTAALT, ';
          strUpdDtaAltera := strUpdDtaAltera + '  ITE_CODOPE = :CODOPE ';

          strUpdDtaAltera := strUpdDtaAltera + ' WHERE ';
          strUpdDtaAltera := strUpdDtaAltera + '  ITE_CODITE = :CODITE AND ';
          strUpdDtaAltera := strUpdDtaAltera + '  LOCATE(ITE_CODEMP, :CODEMP) > 0';

          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdDtaAltera);
          qryGenTmp.ParamByName('CODITE').AsString := strCodIte;
          qryGenTmp.ParamByName('CODEMP').AsString := strEmpresas;
          qryGenTmp.ParamByName('DTAALT').AsDate := VS_Date;
          qryGenTmp.ParamByName('HULALT').AsDateTime := fNow;
          qryGenTmp.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;

          qryGenTmp.ExecSQL;
          qryGenTmp.Close;

          pgbProgresso.StepBy(1);
          Application.ProcessMessages;
          Next;
        End;

        pgbProgresso.Position := 0;
        pgbProgresso.Visible := False;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[fConfirmaItens]');
        End;

      End;
    End;

  Finally

    pgbProgresso.Position := 0;
    pgbProgresso.Visible  := False;
    strAgrupadorPreAlt := '';;
    cdsItens.EnableControls;
    FreeAndNil(qryGenTmp);
    FreeAndNil(qryGenUpd);
    FreeAndNil(qryIteger);
    FreeAndNil(stlDesmarcados);
  End;

end;

procedure TfrmAltPrecoGlobalItensCatalogo.btnDesmarcMarcAllClick(Sender: TObject);
var
  intTamMat: Integer;
begin
  inherited;

  intTamMat   := Length(arrDesmarcados);
  cdsItens.DisableControls;
  cdsItens.First;
  If intTamMat > 0 Then
  Begin
    SetLength(arrDesmarcados, 0);
  End;

  cdsItens.First;
  while Not(cdsItens.eof) do
  Begin
    pSelecionaItem;
    cdsItens.Next;
  End;
  cdsItens.EnableControls;
end;

procedure TfrmAltPrecoGlobalItensCatalogo.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If fMensagem('', 'Confirma Itens?', ['&Sim', '&Não']) = 2 Then
  Begin
    pSetFocus(Self);
    Exit;
  End;

  btnConfirma.Enabled := False;
  btnVoltar.Enabled   := False;

  Screen.Cursor := crHourGlass;
  fStartTransaction;

  If fConfirmaItens Then
  Begin
    fCommit;
    blnConfirma := True;
    Screen.Cursor := crDefault;
    fMensagem('', 'Alteração dos Itens concluída com sucesso!', ['&O k']);
    Close;
  End
  Else
    fRollBack;

  btnConfirma.Enabled := True;
  btnVoltar.Enabled   := True;
  Screen.Cursor := crDefault;
end;

procedure TfrmAltPrecoGlobalItensCatalogo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  fAbrirTabela(qryPreAlt);

  qryPesIte := fCriaQuery(Self);
  qryPesIte.SQL.Text := fSQLCadIte;

  If fCfgSis('FATPRE', varBoolean) Then
    objFatPre := TFatorPreco.Create
  Else
    objFatPre := Nil;

  strTipAbf := fCfgSis('TIPABF');

end;

procedure TfrmAltPrecoGlobalItensCatalogo.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);
  
end;

procedure TfrmAltPrecoGlobalItensCatalogo.dbgItensDblClick(Sender: TObject);
  Var
    Key: Word;
    State: TShiftState;
begin
  inherited;
  Key := VK_Return;
  dbgItensKeyDown(Sender, Key, State);
end;

procedure TfrmAltPrecoGlobalItensCatalogo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryPreAlt);

  cdsItens.Filtered := False;
  cdsItens.Filter := '';
end;

end.


