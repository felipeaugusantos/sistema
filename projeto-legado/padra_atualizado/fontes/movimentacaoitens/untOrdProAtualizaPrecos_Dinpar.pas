unit untOrdProAtualizaPrecos_Dinpar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, untPai, frxClass, untZClient, cxProgressBar,
  frxExportCSVTestabilidade, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, Grids, DBGridCitel, DBGrids, DB, ImgList,
  System.ImageList,  Uni, untTConfiguracao, untParCalculaPrecoCusto, untPreAlt_Trigger, System.UiTypes;

type
  THackDBGrid = class(TDBGrid);

  TTipoAtualizacao = (opcPrecoVenda, opcMargem);
  TTipoMarca = (opcAlterado, opcMenor, opcMaior, opcDesmarcar, opcInverter);

  TfrmOrdProAtualizaPrecos_Dinpar = class(TfrmPai)
    dbgDados: TDBGrid;
    imgLista: TImageList;
    tmrInicializa: TTimer;
    shpUpCusto: TShape;
    shpDownCusto: TShape;
    Label1: TLabel;
    Label2: TLabel;
    dbgComposicao: TDBGrid;
    chkExiCus: TCheckBox;
    btnConfirma: TBitBtnLocked;
    popOpcoes: TPopupMenu;
    Marcartodosalterados1: TMenuItem;
    Marcarapenascomcustomenor1: TMenuItem;
    MarcarapenascomcustoMAIOR1: TMenuItem;
    N1: TMenuItem;
    Desmarcartodos1: TMenuItem;
    BitBtn1: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDadosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure tmrInicializaTimer(Sender: TObject);
    procedure dbgDadosColEnter(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure Marcartodosalterados1Click(Sender: TObject);
    procedure dbgDadosCellClick(Column: TColumn);
    procedure BitBtn1Click(Sender: TObject);
    procedure dbgComposicaoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgComposicaoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    intDecUni: Integer;
    cpcParams: TParCalculaPrecoCusto;


    cdsGerMat : TZClient;
    cdsDetMat : TZClient;

    blnConfirma: Boolean;

    qryUpdCus,
    qryUpDet,
    qryTabDet: TUniQuery;

    strTabPrc : String;
    strPreCus : String;
    intCorZeb : Integer;
    opcTipAtu : TTipoAtualizacao;
    intTabMov : Integer;
    strAgrupadorPreAlt: String;

    function fGetSqlGerMat : String;
    function fGetSqlDetMat : String;
    function fSqlTabDet: String;
    function fSqlUpDet: String;

    function fInicializaProgresso(cxProgress: TcxProgressBar): Boolean;
    function fRecalcularCustos: Boolean;
    function fGravaAlteracoesProgresso(cxProgress: TcxProgressBar):Boolean;
    Function fCarregaCustos(strCodIte, strCodTab, strCodEmp: String): Boolean;

    procedure pAddColunasPreVenMarBru;
    procedure pFormataNumericos;
    procedure pCalculaCusto(strCodIte: String);
    procedure pGerMatAfterScroll(DataSet : TDataSet);
    procedure pMarcar(opcao : TTipoMarca);
  public
    { Public declarations }
  end;

var
  frmOrdProAtualizaPrecos_Dinpar: TfrmOrdProAtualizaPrecos_Dinpar;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untPreAlt, Math;

{ TfrmOrdProAtualizaPrecos_Dinpar }

procedure TfrmOrdProAtualizaPrecos_Dinpar.BitBtn1Click(Sender: TObject);
begin
  inherited;
  popOpcoes.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fGravaAlteracoesProgresso;
  frmGravando.ShowModal;

  If frmGravando.blnConfirma Then
  Begin
    fMensagem('','Atualização realizada com sucesso!', ['&OK']);
    blnConfirma := True;
    Self.Close;
  End;

  FreeAndNil(frmGravando);

end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.dbgComposicaoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDBGrid(Sender) Do
  Begin
    if (DataSource = Nil) Or (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    if Odd(DataSource.DataSet.RecNo) Then
    Begin
      Canvas.Brush.Color := intCorZeb;
      Canvas.Font.Color  := clBlack;
    End;

    if (Tag = THackDBGrid(Sender).DataLink.ActiveRecord + 1) then
    begin
      Canvas.Brush.Color := clSilver;
      Canvas.Font.Color := clNavy;
    end;

    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);

  End;

end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.dbgComposicaoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  Var
    objCord: TGridCoord;
begin
  inherited;

  If (Not Assigned(dbgComposicao)) or (not Assigned(dbgComposicao.DataSource)) Or (not dbgComposicao.DataSource.DataSet.Active) Then
    Exit;

  objCord := dbgComposicao.MouseCoord(X,Y);
  dbgComposicao.Tag := objCord.Y;
  dbgComposicao.Repaint;

end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.dbgDadosCellClick(Column: TColumn);
begin
  inherited;
  if Column.FieldName = 'MARCA' Then
    pMarcar( opcInverter );
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.dbgDadosColEnter(Sender: TObject);
var Rect: TRect;
begin
  inherited;
  If not Assigned(dbgDados) Then
    Exit;

  With dbgDados Do
  Begin
    dbgComposicao.Visible := chkExiCus.Checked And (SelectedField.FieldName = 'NEW_PRECOM') And Assigned(DataSource.DataSet);

    If dbgComposicao.Visible Then
    Begin
      cdsDetMat.Filtered := False;
      cdsDetMat.Filter := 'DMT_SEQGER = ' + QuotedStr(cdsGerMat.FieldByName('AUTOINCREM').AsString);
      cdsDetMat.Filtered := True;
      cdsDetMat.First;

      Rect := THackDBGrid(dbgDados).CellRect(THackDBGrid(dbgDados).col, THackDBGrid(dbgDados).Row);

      dbgComposicao.Top  := dbgDados.Top  + Rect.Top + Rect.Bottom-Rect.Top;
      dbgComposicao.Left := dbgDados.Left + Rect.Left;

      If dbgComposicao.Top + dbgComposicao.Height > ClientHeight then
        dbgComposicao.Top  := dbgComposicao.Top  - dbgComposicao.Height - (Rect.Bottom-Rect.Top);



    End;
  End;
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDBGrid(Sender) Do
  Begin
    if (DataSource = Nil) Or (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    if Odd(DataSource.DataSet.RecNo) Then
    Begin
      Canvas.Brush.Color := intCorZeb;
      Canvas.Font.Color  := clBlack;
    End;

    if (Tag = THackDBGrid(Sender).DataLink.ActiveRecord + 1) then
    begin
      Canvas.Brush.Color := clSilver;
      Canvas.Font.Color := clNavy;

      if (Length(Column.FieldName) >= 10) And (Column.FieldName[10] = IntToStr(intTabMov)) Then
        Canvas.Brush.Color := $004080FF;

    end;

    if SameText(Column.Field.FieldName, 'NEW_PRECUS') then
    Begin

      If RoundTo(DataSource.DataSet.FieldByName('ITE_PRECUS').AsFloat, -intDecUni) <>
         RoundTo(DataSource.DataSet.FieldByName('NEW_PRECUS').AsFloat, -intDecUni) Then
      Begin
        Canvas.Font.Color := clBlack;
        If DataSource.DataSet.FieldByName('NEW_PRECUS').AsFloat > DataSource.DataSet.FieldByName('ITE_PRECUS').AsFloat Then
          Canvas.Brush.Color := shpUpCusto.Brush.Color
        Else
          Canvas.Brush.Color := shpDownCusto.Brush.Color;
      End;

    End;

    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);

    if SameText(Column.Field.FieldName, 'MARCA') then
    Begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left+1, Rect.Top, 0);
      If (Column.Field.AsInteger = 1) then
        imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left+1, Rect.Top+1, 1)
      Else
        imgLista.Draw(TDBGrid(Sender).Canvas, Rect.Left+1, Rect.Top+1, 2);
    End;

    If (SelectedField.FieldName = 'NEW_CUSCHE') And (gdFocused in State) And (dbgComposicao.Visible) then
    Begin
      dbgComposicao.Top  := dbgDados.Top  + Rect.Top + Rect.Bottom-Rect.Top;
      dbgComposicao.Left := dbgDados.Left + Rect.Left;
    End

  End;
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.dbgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_SPACE) or (Key = VK_RETURN) Then
    pMarcar(opcInverter);
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.dbgDadosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  Var
    objCord: TGridCoord;
begin
  inherited;

  If (not Assigned(dbgDados)) or (not Assigned(dbgDados.DataSource)) Or (not dbgDados.DataSource.DataSet.Active) Then
    Exit;

  objCord := dbgDados.MouseCoord(X,Y);
  dbgDados.Tag := objCord.Y;
  dbgDados.Repaint;

  intTabMov := -1;
  If (objCord.X > 0) And (objCord.X < dbgDados.Columns.Count) And (Length(dbgDados.Columns[objCord.X-1].FieldName) >= 10) Then
    intTabMov := StrToIntDef(dbgDados.Columns[objCord.X-1].FieldName[10] ,-1);

  If objCord.X = 1 Then
    Screen.Cursor := crHandPoint
  Else
    Screen.Cursor := crDefault;

end;

function TfrmOrdProAtualizaPrecos_Dinpar.fGetSqlDetMat: String;
begin
  Result := '';
  Result := Result + ' SELECT DMT_SEQGER,                                   ';
  Result := Result + '        DMT_ITESUB,                                   ';
  Result := Result + '        ITE_DESITE,                                   ';
  Result := Result + '        (SELECT COUNT(0)                              ';
  Result := Result + '         FROM GERMAT                                  ';
  Result := Result + '         WHERE GMT_CODITE = DMT_ITESUB) AS ESTRUTURA, ';
  Result := Result + ' DMT_QTDITE * IFNULL(' + strPreCus +',0) AS '+ strPreCus;
  Result := Result + ' FROM DETMAT DM                                       ';
  Result := Result + '   INNER JOIN CADITE CT ON CT.ITE_CODITE = DMT_ITESUB ';
  Result := Result + '   INNER JOIN ITEGER IG                               ';
  Result := Result + '       ON IG.ITE_CODITE = DMT_ITESUB                  ';
  Result := Result + '      AND IG.ITE_CODEMP = :CODEMP                     ';
end;

function TfrmOrdProAtualizaPrecos_Dinpar.fSqlTabDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   IT.ITE_CODFOR, ';
  strSQL := strSQL + '   IT.ITE_CODTAB, ';
  strSQL := strSQL + '   IT.ITE_CODITE, ';
  strSQL := strSQL + '   IT.ITE_PROGER, ';
  strSQL := strSQL + '   IT.ITE_DESGER, ';
  strSQL := strSQL + '   IT.ITE_CNVCUS, ';

  strSQL := strSQL + '   TD.ITE_PREDOL, ';

  strSQL := strSQL + '   TD.ITE_CODEMP, ';
  strSQL := strSQL + '   TD.ITE_CODABF, ';
  strSQL := strSQL + '   TD.ITE_SUBSTI, ';
  strSQL := strSQL + '   TD.ITE_DESF01, ';
  strSQL := strSQL + '   TD.ITE_DESF02, ';
  strSQL := strSQL + '   TD.ITE_DESF03, ';
  strSQL := strSQL + '   TD.ITE_DESF04, ';
  strSQL := strSQL + '   TD.ITE_DESF05, ';
  strSQL := strSQL + '   TD.ITE_DESF06, ';
  strSQL := strSQL + '   TD.ITE_ICMENT, ';
  strSQL := strSQL + '   TD.ITE_SUBFED, ';
  strSQL := strSQL + '   TD.ITE_IPIENT, ';
  strSQL := strSQL + '   TD.ITE_FREENT, ';
  strSQL := strSQL + '   TD.ITE_VALFRE, ';
  strSQL := strSQL + '   TD.ITE_ACRFIN, ';
  strSQL := strSQL + '   TD.ITE_SUBSTI, ';
  strSQL := strSQL + '   TD.ITE_DESADB, ';
  strSQL := strSQL + '   TD.ITE_IMPFED, ';
  strSQL := strSQL + '   TD.ITE_PRECUS, ';

  strSQL := strSQL + '   C1.DET_ICMSAI AS DET_ICMSAI1, ';
  strSQL := strSQL + '   C1.DET_OUTVAL AS DET_OUTVAL1, ';
  strSQL := strSQL + '   C1.DET_DESOPE AS DET_DESOPE1, ';

  strSQL := strSQL + '   C2.DET_ICMSAI AS DET_ICMSAI2, ';
  strSQL := strSQL + '   C2.DET_OUTVAL AS DET_OUTVAL2, ';
  strSQL := strSQL + '   C2.DET_DESOPE AS DET_DESOPE2, ';

  strSQL := strSQL + '   C3.DET_ICMSAI AS DET_ICMSAI3, ';
  strSQL := strSQL + '   C3.DET_OUTVAL AS DET_OUTVAL3, ';
  strSQL := strSQL + '   C3.DET_DESOPE AS DET_DESOPE3, ';

  strSQL := strSQL + '   C4.DET_ICMSAI AS DET_ICMSAI4, ';
  strSQL := strSQL + '   C4.DET_OUTVAL AS DET_OUTVAL4, ';
  strSQL := strSQL + '   C4.DET_DESOPE AS DET_DESOPE4, ';

  strSQL := strSQL + '   C5.DET_ICMSAI AS DET_ICMSAI5, ';
  strSQL := strSQL + '   C5.DET_OUTVAL AS DET_OUTVAL5, ';
  strSQL := strSQL + '   C5.DET_DESOPE AS DET_DESOPE5, ';

  strSQL := strSQL + '   C6.DET_ICMSAI AS DET_ICMSAI6, ';
  strSQL := strSQL + '   C6.DET_OUTVAL AS DET_OUTVAL6, ';
  strSQL := strSQL + '   C6.DET_DESOPE AS DET_DESOPE6, ';

  strSQL := strSQL + '   C7.DET_ICMSAI AS DET_ICMSAI7, ';
  strSQL := strSQL + '   C7.DET_OUTVAL AS DET_OUTVAL7, ';
  strSQL := strSQL + '   C7.DET_DESOPE AS DET_DESOPE7, ';

  strSQL := strSQL + '   TD.ITE_PRECOM  ';

  strSQL := strSQL + ' FROM        ';
  strSQL := strSQL + '   ITEFOR IT ';
  strSQL := strSQL + ' INNER JOIN TABDET TD ON TD.ITE_SEQGER = IT.AUTOINCREM ';
  strSQL := strSQL + '                     AND IT.ITE_CODITE = :CODITE       ';
  strSQL := strSQL + '                     AND IT.ITE_CODTAB = :CODTAB       ';
  strSQL := strSQL + '                     AND TD.ITE_CODEMP = :CODEMP       ';
  strSQL := strSQL + '   INNER JOIN DETCUS C1 ON C1.DET_SEQDET = TD.AUTOINCREM AND C1.DET_TABELA = 1 ';
  strSQL := strSQL + '   INNER JOIN DETCUS C2 ON C2.DET_SEQDET = TD.AUTOINCREM AND C2.DET_TABELA = 2 ';
  strSQL := strSQL + '   INNER JOIN DETCUS C3 ON C3.DET_SEQDET = TD.AUTOINCREM AND C3.DET_TABELA = 3 ';
  strSQL := strSQL + '   INNER JOIN DETCUS C4 ON C4.DET_SEQDET = TD.AUTOINCREM AND C4.DET_TABELA = 4 ';
  strSQL := strSQL + '   INNER JOIN DETCUS C5 ON C5.DET_SEQDET = TD.AUTOINCREM AND C5.DET_TABELA = 5 ';
  strSQL := strSQL + '   INNER JOIN DETCUS C6 ON C6.DET_SEQDET = TD.AUTOINCREM AND C6.DET_TABELA = 6 ';
  strSQL := strSQL + '   INNER JOIN DETCUS C7 ON C7.DET_SEQDET = TD.AUTOINCREM AND C7.DET_TABELA = 7 ';

  Result := strSQL;
End;

function TfrmOrdProAtualizaPrecos_Dinpar.fSqlUpDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE TABDET TD ';
  strSQL := strSQL + ' INNER JOIN ITEFOR IT ON TD.ITE_SEQGER = IT.AUTOINCREM ';
  strSQL := strSQL + '                     AND IT.ITE_CODITE = :CODITE       ';
  strSQL := strSQL + '                     AND IT.ITE_CODTAB = :CODTAB       ';
  strSQL := strSQL + '                     AND TD.ITE_CODEMP = :CODEMP       ';

  strSQL := strSQL + ' SET                         ';
  strSQL := strSQL + '   TD.ITE_PRECUS = :PRECUS, ';
  strSQL := strSQL + '   TD.ITE_PRECOM = :PRECOM  ';

  Result := strSQL;
End;

Function TfrmOrdProAtualizaPrecos_Dinpar.fCarregaCustos(strCodIte, strCodTab, strCodEmp: String): Boolean;
Begin
  With qryTabDet Do
  Begin
    If IsEmpty Or (FieldByName('ITE_CODTAB').AsString <> strCodTab) Or
                  (FieldByName('ITE_CODITE').AsString <> strCodIte) Or
                  (FieldByName('ITE_CODEMP').AsString <> strCodEmp) Then
    Begin
      Close;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODTAB').AsString := strCodTab;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
    End;

    Result := Not IsEmpty;
  End;
End;

function TfrmOrdProAtualizaPrecos_Dinpar.fGetSqlGerMat: String;
  Var
    intIndex : Integer;
Begin

  Result := '';
  Result := Result + ' SELECT 0 AS MARCA   ,                                 ';
  Result := Result + '        0 AS CALCU   ,                                 ';
  Result := Result + '        GM.AUTOINCREM,                                 ';
  Result := Result + '        IG.ITE_CODITE,                                 ';
  Result := Result + '        CT.ITE_DESITE,                                 ';
  Result := Result + '        IG.ITE_PRECUS,                                 ';
  Result := Result + '        IG.ITE_PRECOM,                                 ';

  Result := Result + '   0.00 AS NEW_PRECUS,                                 ';
  Result := Result + '   0.00 AS NEW_PRECOM                                  ';

  For intIndex := 1 To Length(strTabPrc) Do
  Begin
    Result := Result + ',';

    Result := Result + '   0.00 AS NEW_PRECUS'+intToStr(intIndex)+',         ';
    Result := Result + '   0.00 AS CNVCUS'+intToStr(intIndex)+',         ';

    Result := Result + '        IG.ITE_TABPR'+intToStr(intIndex)+', ';
    Result := Result + '        IG.ITE_PREVE'+intToStr(intIndex)+', ';
    Result := Result + '        IG.ITE_MARBR'+intToStr(intIndex)+', ';
    Result := Result + '        IG.ITE_PREVE'+intToStr(intIndex)+ ' AS NEW_PREVE'+intToStr(intIndex)+', ';
    Result := Result + '        IG.ITE_MARBR'+intToStr(intIndex)+ ' AS NEW_MARBR'+intToStr(intIndex)+', ';
    Result := Result + '        IG.ITE_COMTB'+intToStr(intIndex);

  End;
  Result := Result + ' FROM GERMAT GM                                        ';
  Result := Result + '   INNER JOIN CADITE CT ON CT.ITE_CODITE = GMT_CODITE  ';

  Result := Result + '   INNER JOIN ITEGER IG ON IG.ITE_CODITE = GMT_CODITE  ';
  Result := Result + '                       AND IG.ITE_CODEMP = :CODEMP     ';
end;

function TfrmOrdProAtualizaPrecos_Dinpar.fGravaAlteracoesProgresso(
  cxProgress: TcxProgressBar): Boolean;
  Var
    qryUpdate : TUniQuery;
    intIndex  : Integer;
    strUpdate : String;
begin
  Result := True;
  Try
    strUpdate := '';
    strUpdate := strUpdate + ' UPDATE ITEGER SET ITE_PREALT = :PREALT, ITE_PRECUS = :PRECUS, ITE_PRECOM = :PRECOM, ';

    For intIndex := 1 To Length(strTabPrc) Do
    Begin
      strUpdate := strUpdate + ' ITE_PREVE'+ IntToStr(intIndex) + ' = :PREVE'+ IntToStr(intIndex) + ',';
      strUpdate := strUpdate + ' ITE_MARBR'+ IntToStr(intIndex) + ' = :MARBR'+ IntToStr(intIndex) + ',';
    End;
    
    strUpdate := Copy(strUpdate,1, Length(strUpdate)-1); //Tira a virgula que vai passar;
    strUpdate := strUpdate + ' WHERE ITE_CODITE = :CODITE ';
    strUpdate := strUpdate + '   AND LOCATE(ITE_CODEMP, "' + fRetEmpresasUsamPrecoMatriz + '") > 0 ';

    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(strUpdate);
    End;

    cdsGerMat.AfterScroll := Nil;
    cdsGerMat.DisableControls;
    cdsGerMat.Filtered := False;
    cdsGerMat.Filter   := 'MARCA = 1';
    cdsGerMat.Filtered := True;
    cdsGerMat.First;

    cxProgress.Properties.Max := cdsGerMat.RecordCount;


    pPreAltDefineVariaveisAltPre(fNow,'ATUALIZA PRECOS DINPAR', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    While Result And (not cdsGerMat.Eof) Do
    Begin
      fStartTransaction;

      qryUpdate.ParamByName('CODITE').AsString := cdsGerMat.FieldByName('ITE_CODITE').AsString;
      qryUpdate.ParamByName('PRECOM').AsFloat  := cdsGerMat.FieldByName('NEW_PRECOM').AsFloat;
      qryUpdate.ParamByName('PRECUS').AsFloat  := cdsGerMat.FieldByName('NEW_PRECUS').AsFloat;
      qryUpdate.ParamByName('PREALT').AsString := strAgrupadorPreAlt;

      For intIndex := 1 To Length(strTabPrc) Do
      Begin

        qryUpdate.ParamByName('PREVE'+ IntToStr(intIndex)).AsFloat := cdsGerMat.FieldByName('NEW_PREVE'+ IntToStr(intIndex)).AsFloat;
        qryUpdate.ParamByName('MARBR'+ IntToStr(intIndex)).AsFloat := cdsGerMat.FieldByName('NEW_MARBR'+ IntToStr(intIndex)).AsFloat;

        If Not fEmptyStr(cdsGerMat.FieldByName('ITE_TABPR'+ IntToStr(intIndex)).AsString) Then
        Begin

          qryUpDet.Close;
          qryUpDet.ParamByName('CODTAB').AsString := cdsGerMat.FieldByName('ITE_TABPR'+ IntToStr(intIndex)).AsString;
          qryUpDet.ParamByName('CODITE').AsString := cdsGerMat.FieldByName('ITE_CODITE').AsString;
          qryUpDet.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryUpDet.ParamByName('PRECOM').AsFloat  := cdsGerMat.FieldByName('NEW_PRECOM').AsFloat * cdsGerMat.FieldByName('CNVCUS' + IntToStr(intIndex)).AsFloat;
          qryUpDet.ParamByName('PRECUS').AsFloat  := cdsGerMat.FieldByName('NEW_PRECUS'+ IntToStr(intIndex)).AsFloat * cdsGerMat.FieldByName('CNVCUS' + IntToStr(intIndex)).AsFloat;
          qryUpDet.ExecSql;



          qryUpdCus.ParamByName('PREVEN').AsFloat := cdsGerMat.FieldByName('NEW_PREVE'+ IntToStr(intIndex)).AsFloat * cdsGerMat.FieldByName('CNVCUS' + IntToStr(intIndex)).AsFloat;
          qryUpdCus.ParamByName('MARBRU').AsFloat := cdsGerMat.FieldByName('NEW_MARBR'+ IntToStr(intIndex)).AsFloat;
          qryUpdCus.ParamByName('CODITE').AsString := cdsGerMat.FieldByName('ITE_CODITE').AsString;
          qryUpdCus.ParamByName('CODTAB').AsString := cdsGerMat.FieldByName('ITE_TABPR'+ IntToStr(intIndex)).AsString;
          qryUpdCus.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryUpdCus.ParamByName('TABELA').AsInteger := intIndex;
          qryUpdCus.ExecSQL;
        End;

      End;

      Try
        qryUpdate.ExecSql;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(e.Message,'TfrmOrdProAtualizaPrecos_Dinpar.fGravaAlteracoesProgresso');
        End;
      End;

      If Result Then
      begin
        If Not VS_blnPreAltViaTrigger Then
          Result := fGravaPreAlt(cdsGerMat.FieldByName('ITE_CODITE').AsString,

                                 cdsGerMat.FieldByName('ITE_PRECUS').AsFloat,
                                 cdsGerMat.FieldByName('NEW_PRECUS').AsFloat,

                                 IIF(strTabPrc[1]='N', 0, cdsGerMat.FieldByName('ITE_PREVE1').AsFloat),
                                 IIF(strTabPrc[1]='N', 0, cdsGerMat.FieldByName('NEW_PREVE1').AsFloat),
                                 IIF(strTabPrc[1]='N', 0, cdsGerMat.FieldByName('ITE_MARBR1').AsFloat),
                                 IIF(strTabPrc[1]='N', 0, cdsGerMat.FieldByName('NEW_MARBR1').AsFloat),

                                 IIF(strTabPrc[2]='N', 0, cdsGerMat.FieldByName('ITE_PREVE2').AsFloat),
                                 IIF(strTabPrc[2]='N', 0, cdsGerMat.FieldByName('NEW_PREVE2').AsFloat),
                                 IIF(strTabPrc[2]='N', 0, cdsGerMat.FieldByName('ITE_MARBR2').AsFloat),
                                 IIF(strTabPrc[2]='N', 0, cdsGerMat.FieldByName('NEW_MARBR2').AsFloat),

                                 IIF(strTabPrc[3]='N', 0, cdsGerMat.FieldByName('ITE_PREVE3').AsFloat),
                                 IIF(strTabPrc[3]='N', 0, cdsGerMat.FieldByName('NEW_PREVE3').AsFloat),
                                 IIF(strTabPrc[3]='N', 0, cdsGerMat.FieldByName('ITE_MARBR3').AsFloat),
                                 IIF(strTabPrc[3]='N', 0, cdsGerMat.FieldByName('NEW_MARBR3').AsFloat),

                                 IIF(strTabPrc[4]='N', 0, cdsGerMat.FieldByName('ITE_PREVE4').AsFloat),
                                 IIF(strTabPrc[4]='N', 0, cdsGerMat.FieldByName('NEW_PREVE4').AsFloat),
                                 IIF(strTabPrc[4]='N', 0, cdsGerMat.FieldByName('ITE_MARBR4').AsFloat),
                                 IIF(strTabPrc[4]='N', 0, cdsGerMat.FieldByName('NEW_MARBR4').AsFloat),

                                 IIF(strTabPrc[5]='N', 0, cdsGerMat.FieldByName('ITE_PREVE5').AsFloat),
                                 IIF(strTabPrc[5]='N', 0, cdsGerMat.FieldByName('NEW_PREVE5').AsFloat),
                                 IIF(strTabPrc[5]='N', 0, cdsGerMat.FieldByName('ITE_MARBR5').AsFloat),
                                 IIF(strTabPrc[5]='N', 0, cdsGerMat.FieldByName('NEW_MARBR5').AsFloat),

                                 IIF(strTabPrc[6]='N', 0, cdsGerMat.FieldByName('ITE_PREVE6').AsFloat),
                                 IIF(strTabPrc[6]='N', 0, cdsGerMat.FieldByName('NEW_PREVE6').AsFloat),
                                 IIF(strTabPrc[6]='N', 0, cdsGerMat.FieldByName('ITE_MARBR6').AsFloat),
                                 IIF(strTabPrc[6]='N', 0, cdsGerMat.FieldByName('NEW_MARBR6').AsFloat),

                                 IIF(strTabPrc[7]='N', 0, cdsGerMat.FieldByName('ITE_PREVE7').AsFloat),
                                 IIF(strTabPrc[7]='N', 0, cdsGerMat.FieldByName('NEW_PREVE7').AsFloat),
                                 IIF(strTabPrc[7]='N', 0, cdsGerMat.FieldByName('ITE_MARBR7').AsFloat),
                                 IIF(strTabPrc[7]='N', 0, cdsGerMat.FieldByName('NEW_MARBR7').AsFloat),

                                 cdsGerMat.FieldByName('ITE_PRECOM').AsFloat,
                                 cdsGerMat.FieldByName('NEW_PRECOM').AsFloat,

                                 Self.Name);
      End;

      If Result Then
        fCommit
      Else
        fRollBack;

      cdsGerMat.Next;

      cxProgress.Position := cxProgress.Position + 1;

      Application.ProcessMessages;

    End;

  Finally
    If Result Then
      fCommit
    Else
      fRollBack;

    FreeAndNil(qryUpdate);

    cdsGerMat.AfterScroll := pGerMatAfterScroll;
    cdsGerMat.EnableControls;
    cdsGerMat.Filtered := False;
    cdsGerMat.Filter   := '';
    strAgrupadorPreAlt := '';
  End;

end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dbgDados.OnMouseMove      := Nil;
  dbgComposicao.OnMouseMove := Nil;

  If Not blnConfirma Then
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;
  End;


end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.FormCreate(Sender: TObject);
begin
  inherited;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao, True, True);

  blnConfirma := False;

  intCorZeb := fCfgSis('CORZEB', varInteger);
  strTabPrc := fCfgSis('TABPRC', varString);
  intDecUni := fCfgSis('DECUNI', varInteger);

  strPreCus := 'ITE_PRECUS';

  qryTabDet := fCriaQuery(Self);
  qryUpdCus := fCriaQuery(Self);

  qryUpdCus.SQL.Add('UPDATE TABDET D');
  qryUpdCus.SQL.Add(' INNER JOIN DETCUS C ON C.DET_SEQDET = D.AUTOINCREM');
  qryUpdCus.SQL.Add('   SET DET_PREVEN = :PREVEN,');
  qryUpdCus.SQL.Add('       DET_MARBRU = :MARBRU');
  qryUpdCus.SQL.Add(' WHERE D.ITE_CODITE = :CODITE');
  qryUpdCus.SQL.Add('   AND D.ITE_CODTAB = :CODTAB');
  qryUpdCus.SQL.Add('   AND D.ITE_CODEMP = :CODEMP');
  qryUpdCus.SQL.Add('   AND C.DET_TABELA = :TABELA');

  qryTabDet.SQL.Text := fSqlTabDet;

  qryUpDet := fCriaQuery(Self);
  qryUpDet.SQL.Text := fSqlUpDet;
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryUpdCus);
  FreeAndNil(cpcParams);
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    Self.Close;
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.pFormataNumericos;
  Var
    intIndex : Integer;
Begin
  For intIndex := 0 To cdsGerMat.Fields.Count -1 Do
  Begin
    If cdsGerMat.Fields[intIndex] Is TFloatField Then
      TFloatField(cdsGerMat.Fields[intIndex]).DisplayFormat := fMskDigitos(intDecUni);
  End;

  For intIndex := 0 To cdsDetMat.Fields.Count -1 Do
  Begin
    If cdsDetMat.Fields[intIndex] Is TFloatField Then
      TFloatField(cdsDetMat.Fields[intIndex]).DisplayFormat := fMskDigitos(intDecUni);
  End;

End;

procedure TfrmOrdProAtualizaPrecos_Dinpar.pGerMatAfterScroll(DataSet: TDataSet);
begin
  dbgDadosColEnter(dbgDados);
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.pMarcar(opcao: TTipoMarca);
begin
  With cdsGerMat Do
  Begin
    If RoundTo(FieldByName('NEW_PRECUS').AsFloat, -intDecUni) = RoundTo(FieldByName('ITE_PRECUS').AsFloat, -intDecUni) Then
      Exit;

    Edit;
    Case Opcao Of
      opcMenor    : FieldByName('MARCA').AsInteger := IIF(FieldByName('NEW_PRECUS').AsFloat > FieldByName('ITE_PRECUS').AsFloat, 0, 1);
      opcMaior    : FieldByName('MARCA').AsInteger := IIF(FieldByName('NEW_PRECUS').AsFloat > FieldByName('ITE_PRECUS').AsFloat, 1, 0);
      opcAlterado : FieldByName('MARCA').AsInteger := 1;
      opcDesmarcar: FieldByName('MARCA').AsInteger := 0;
      opcInverter : FieldByName('MARCA').AsInteger := IIF(FieldByName('MARCA').AsInteger = 0, 1, 0);
    End;

    Post;
  End;
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.tmrInicializaTimer(Sender: TObject);
  Var
    blnSai : Boolean;
begin
  inherited;
  blnSai := False;
  tmrInicializa.Enabled := False;

  Case fMensagem('ATENÇÃO',
                 'Esta rotina atualiza o preço de custo dos produtos estrutura, somando o preço de custo de seus sub-produtos.' + #13 +    'Deseja Recalcular:',
                 ['Anular', 'Preço de Venda', 'Margem'],
                 1,
                 False,
                 1,
                 0,
                 False) Of
    1: blnSai := True;
    2: opcTipAtu := opcPrecoVenda;
    3: opcTipAtu := opcMargem;
  End;


  If Not blnSai Then
  Begin
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fInicializaProgresso;
    frmGravando.ShowModal;
    FreeAndNil(frmGravando);
  End
  Else
    Close;
end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.pAddColunasPreVenMarBru;
  Var
    intIndex : Integer;
Begin
  For intIndex := 1 To Length(strTabPrc) Do
  Begin
    If strTabPrc[intIndex] = 'S' Then
    Begin
      If opcTipAtu = opcPrecoVenda Then
      Begin
        With dbgDados.Columns.Add Do
        Begin
          FieldName := 'ITE_PREVE' + IntToStr(intIndex);
          Title.Caption := 'Pr. Venda ' + IntToStr(intIndex) + ' Ant.';
          Width := 90;
        End;
      End;

      With dbgDados.Columns.Add Do
      Begin
        FieldName := 'NEW_PREVE' + IntToStr(intIndex);
        Title.Caption := 'Pr. Venda ' + IntToStr(intIndex) + IIF( opcTipAtu = opcPrecoVenda, ' Novo', '');
        Width := 90;
      End;

      If opcTipAtu = opcMargem Then
      Begin
        With dbgDados.Columns.Add Do
        Begin
          FieldName := 'ITE_MARBR' + IntToStr(intIndex);
          Title.Caption := 'Margem ' + IntToStr(intIndex) + ' Ant.';
          Width := 90;
        End;
      End;

      With dbgDados.Columns.Add Do
      Begin
        FieldName := 'NEW_MARBR' + IntToStr(intIndex);
        Title.Caption := 'Margem ' + IntToStr(intIndex) + IIF( opcTipAtu = opcMargem, ' Novo', '');
        Width := 90;
      End;

    End;

  End;

End;

procedure TfrmOrdProAtualizaPrecos_Dinpar.FormShow(Sender: TObject);
begin
  inherited;
  tmrInicializa.Enabled := True;
  pSetFocus(dbgDados);
end;

function TfrmOrdProAtualizaPrecos_Dinpar.fInicializaProgresso(cxProgress : TcxProgressBar) : Boolean;
Begin
  If Assigned(frmGravando) Then
  Begin
    With frmGravando Do
      lblGravando.Caption := 'Carregando Registros...';
  End;

  Application.ProcessMessages;

  cdsGerMat := TZClient.Create(Self, fGetSqlGerMat);
  cdsGerMat.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  cdsGerMat.fAbreClient(True, 'TfrmOrdProAtualizaPrecos_Dinpar.FormCreate');

  cxProgress.Properties.Max := cdsGerMat.RecordCount;

  cdsDetMat := TZClient.Create(Self, fGetSqlDetMat);
  cdsDetMat.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  cdsDetMat.fAbreClient(True, 'TfrmOrdProAtualizaPrecos_Dinpar.FormCreate');

  pFormataNumericos;
  pAddColunasPreVenMarBru;

  If Assigned(frmGravando) Then
  Begin
    With frmGravando Do
      lblGravando.Caption := 'Calculando custos...';
  End;

  Result := fRecalcularCustos;

  dbgDados.DataSource := cdsGerMat.dtsSource;
  dbgComposicao.DataSource := cdsDetMat.dtsSource;
  dbgComposicao.Columns[2].FieldName := strPreCus;

  cdsGerMat.AfterScroll := pGerMatAfterScroll;

End;

function TfrmOrdProAtualizaPrecos_Dinpar.fRecalcularCustos : Boolean;
Begin
  try
    Try
      cdsGerMat.DisableControls;
      cdsGerMat.First;

      While Not cdsGerMat.Eof Do
      Begin
        If Assigned(frmGravando) Then
          frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;

        pCalculaCusto( cdsGerMat.FieldByName('ITE_CODITE').AsString );
        cdsGerMat.Next;

        Application.ProcessMessages;
      End;
      Result := True;
    Finally
      cdsGerMat.First;
      cdsGerMat.EnableControls;
    End;
  Except
    Result := False;
  End;

End;

procedure TfrmOrdProAtualizaPrecos_Dinpar.Marcartodosalterados1Click(Sender: TObject);
begin
  inherited;
  Try
    cdsGerMat.DisableControls;
    cdsGerMat.First;

    While Not cdsGerMat.Eof Do
    Begin
      Case TMenuItem(Sender).Tag Of
        1: pMarcar( opcAlterado );
        2: pMarcar( opcMenor );
        3: pMarcar( opcMaior );
        4: pMarcar( opcDesmarcar );
      End;

      cdsGerMat.Next;
    End;

  Finally
    cdsGerMat.First;
    cdsGerMat.EnableControls;
  End;

end;

procedure TfrmOrdProAtualizaPrecos_Dinpar.pCalculaCusto(strCodIte : String);
  Var
//    fltCusGer,
    fltPreCus : Double;
    intIndex  : Integer;
    blnAtivou : Boolean;

    Function fCalculaPrecoCompraLiq: Double;
    Begin
      With cpcParams, qryTabDet Do
      Begin
        Result := untfuncoesSimples.fCalculaPrecoCompraLiq(
                                   cdsGerMat.FieldByName('NEW_PRECOM').AsFloat,
                                   FieldByName('ITE_DESF01').AsFloat,
                                   FieldByName('ITE_DESF02').AsFloat,
                                   FieldByName('ITE_DESF03').AsFloat,
                                   FieldByName('ITE_DESF04').AsFloat,
                                   FieldByName('ITE_DESF05').AsFloat,
                                   FieldByName('ITE_DESF06').AsFloat);
      End;
    End;

  function fRetPrecoCustoCheio: Double;
  begin
    With cpcParams, qryTabDet Do
    Begin

      curPreCom := cdsGerMat.FieldByName('NEW_PRECOM').AsFloat;
      curDesF01 := FieldByName('ITE_DESF01').AsFloat;
      curDesF02 := FieldByName('ITE_DESF02').AsFloat;
      curDesF03 := FieldByName('ITE_DESF03').AsFloat;
      curDesF04 := FieldByName('ITE_DESF04').AsFloat;
      curDesF05 := FieldByName('ITE_DESF05').AsFloat;
      curDesF06 := FieldByName('ITE_DESF06').AsFloat;
      curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
      curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
      curFrete  := FieldByName('ITE_FREENT').AsFloat;
      curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
      curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
      curValFre := FieldByName('ITE_VALFRE').AsFloat;
      curDesAdb := FieldByName('ITE_DESADB').AsFloat;
      curSubFed := FieldByName('ITE_SUBFED').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
        curTSCust := FieldByName('ITE_TSCUST').AsFloat;
        curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
        curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
        curFatReg := FieldByName('ITE_FATREG').AsFloat;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
      Result := cpcParams.fCalculaPrecoCusto(IIF(FieldByName('ITE_PREDOL').AsString = 'S', true, false));
    End;
  End;

Begin
  If cdsGerMat.FieldByName('ITE_CODITE').AsString <> strCodIte Then
    If Not cdsGerMat.Locate('ITE_CODITE', strCodIte, [] ) Then
      Exit;


  cdsDetMat.Filtered := False;
  cdsDetMat.Filter := 'DMT_SEQGER = ' + QuotedStr(cdsGerMat.FieldByName('AUTOINCREM').AsString);
  cdsDetMat.Filtered := True;

  fltPreCus := 0;
  While not cdsDetMat.Eof Do
  Begin
    fltPreCus := fltPreCus + cdsDetMat.FieldByName(strPreCus).AsFloat;
    cdsDetMat.Next;
  End;

  cdsGerMat.Edit;
  cdsGerMat.FieldByName('CALCU').AsInteger    := 1;

  cdsGerMat.FieldByName('NEW_PRECOM').AsFloat := fltPreCus;

  blnAtivou := False;

  For intIndex := 1 To Length(strTabPrc) Do
  Begin

    If fCarregaCustos(cdsGerMat.FieldByName('ITE_CODITE').AsString,
                      cdsGerMat.FieldByName('ITE_TABPR' + IntToStr(intIndex)).AsString,
                      VS_strCodEmp) Then
    Begin
      cdsGerMat.FieldByName('NEW_PRECUS' + IntToStr(intIndex)).AsFloat := fRetPrecoCustoCheio;

      If (Not blnAtivou) And (VS_strTabPrc[intIndex] = 'S') Then
      Begin
        blnAtivou := True;

        cdsGerMat.FieldByName('NEW_PRECUS').Value := cdsGerMat.FieldByName('NEW_PRECUS' + IntToStr(intIndex)).Value;

        If RoundTo(cdsGerMat.FieldByName('NEW_PRECUS').AsFloat, -intDecUni) <> RoundTo(cdsGerMat.FieldByName('ITE_PRECUS').AsFloat, -intDecUni) Then
           cdsGerMat.FieldByName('MARCA').AsInteger := 1;
      End;


      cdsGerMat.FieldByName('CNVCUS' + IntToStr(intIndex)).AsFloat := IIf(qryTabDet.FieldByName('ITE_CNVCUS').AsFloat = 0, 1, qryTabDet.FieldByName('ITE_CNVCUS').AsFloat);
      Case opcTipAtu Of
        opcPrecoVenda : cdsGerMat.FieldByName('NEW_PREVE' + IntToStr(intIndex)).AsFloat := fCalculaPrecoVenda(1,
                                                                                            cdsGerMat.FieldByName('NEW_PRECUS' + IntToStr(intIndex)).AsFloat + (qryTabDet.FieldByName('DET_OUTVAL'+ IntToStr(intIndex)).AsFloat / qryTabDet.FieldByName('ITE_CNVCUS').AsFloat),
                                                                                            cdsGerMat.FieldByName('ITE_PREVE' + IntToStr(intIndex)).AsFloat,
                                                                                            cdsGerMat.FieldByName('ITE_MARBR' + IntToStr(intIndex)).AsFloat,
                                                                                            qryTabDet.FieldByName('DET_ICMSAI'+ IntToStr(intIndex)).AsFloat,
                                                                                            qryTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                                                            qryTabDet.FieldByName('DET_DESOPE'+ IntToStr(intIndex)).AsFloat,
                                                                                            cdsGerMat.FieldByName('ITE_COMTB' + IntToStr(intIndex)).AsFloat);


        opcMargem :     cdsGerMat.FieldByName('NEW_MARBR' + IntToStr(intIndex)).AsFloat := fCalculaPrecoVenda(2,
                                                                                            cdsGerMat.FieldByName('NEW_PRECUS' + IntToStr(intIndex)).AsFloat + (qryTabDet.FieldByName('DET_OUTVAL'+ IntToStr(intIndex)).AsFloat / qryTabDet.FieldByName('ITE_CNVCUS').AsFloat),
                                                                                            cdsGerMat.FieldByName('ITE_PREVE' + IntToStr(intIndex)).AsFloat,
                                                                                            cdsGerMat.FieldByName('ITE_MARBR' + IntToStr(intIndex)).AsFloat,
                                                                                            qryTabDet.FieldByName('DET_OUTVAL'+ IntToStr(intIndex)).AsFloat,
                                                                                            qryTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                                                            qryTabDet.FieldByName('DET_OUTVAL'+ IntToStr(intIndex)).AsFloat,
                                                                                            cdsGerMat.FieldByName('ITE_COMTB' + IntToStr(intIndex)).AsFloat);

      End;

    End;

  End;

  cdsGerMat.Post;

End;

end.
