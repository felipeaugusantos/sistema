unit untAltPrecoFornecedorItens;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, ComCtrls,
  Buttons, ExtCtrls, untfuncoesSimples, DB, StrUtils, Menus, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmAltPrecoFornecedorItens = class(TfrmPaiSimples)
    pnlBotoesEnt: TPanel;
    dbgItens: TDBGridCitel;
    pgbProgresso: TProgressBar;
    dtsItens: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnMarTod: TBitBtnLocked;
    btnDesTod: TBitBtnLocked;
    btnVoltar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure btnMarTodClick(Sender: TObject);
  private
    { Private declarations }
    strUsaPreMat: String;
    arrCamposGrid: Array Of TCampoGlobal;
    qryGenIte: TUniQuery;

    Function fGravaAlteracaoPreco(qryUpdateIteger: TUniQuery): Boolean;

//    Procedure pAtualizaCamposIteForNoIteger(strCodIte, strCodEmp, strCodTab: String);
    procedure pOrdenaColunas(strNomCam: String);

    procedure pMarcaItem(blnMarcar: Boolean);
    procedure pSelecionaItem;
    procedure pAdicionaColuna(strTitulo, strCampo: String);

(*    Procedure pRetMargemPrecoItem(strCodIte, strCodEmp: String; intTabPre: Integer;
                                  Var fltPreVen, fltMarBru: Double);
    Procedure pAtualizaIteger(strCodIte, strCodEmp, strNomCam: String;
                              fltValor: Double); *)

    function fAtualizaIteger: Boolean;
    function fAtualizaItegerCustos: Boolean;
    function fAtualizaMargemPrecoVendaIteger(strNomCam: String): Boolean;

    function fConfirmaItens: Boolean;
    procedure pSalvaDetCus(strAutoIncrem: String; Tabela: integer; fltIcmSai,
                           fltDesOpe, fltOutVal, fltMarBru, fltPreven: Double);

    Function fRetColuna(strNomCam: String): TColumn;
   // Function fSQLPrecos: String;
  //  Function fUsaPrecoMatriz(strCodEmp: String): Boolean;

  public
    { Public declarations }
    blnTabPrd,
    blnConfirma: Boolean;

    intOpcAlt: Integer;
    pgbProBar: TProgressBar;
    lblContador: TLabel;

    Function fConfirma: Boolean;

    procedure pAtualizaTabela;

    procedure pCopiaCamposGrid(arrCampos: Array Of TCampoGlobal);
  end;

var
  frmAltPrecoFornecedorItens: TfrmAltPrecoFornecedorItens;

implementation

{$R *.dfm}

{ TfrmAltPrecoGlobalItens }

Uses
  UniClientDataSet,
  untConstantes,
  untPreAlt,
  untPreAlt_Trigger,
  untAltPrecoFornecedor;

 (*
Function TfrmAltPrecoFornecedorItens.fUsaPrecoMatriz(strCodEmp: String): Boolean;
Begin
  Result := Pos(strCodEmp, strUsaPreMat) > 0;
End;
*)

procedure TfrmAltPrecoFornecedorItens.pAdicionaColuna(strTitulo, strCampo: String);
Begin
  dbgItens.Columns.Add;
  dbgItens.Columns[dbgItens.Columns.Count -1].Title.Caption := strTitulo;
  dbgItens.Columns[dbgItens.Columns.Count -1].FieldName     := strCampo;
End;

Function TfrmAltPrecoFornecedorItens.fRetColuna(strNomCam: String): TColumn;
  Var
    intColunas: Integer;
Begin
  Result := Nil;

  For intColunas := 0 To dbgItens.Columns.Count - 1 Do
    If strNomCam = dbgItens.Columns[intColunas].FieldName Then
    Begin
      Result := dbgItens.Columns[intColunas];
      Break;
    End;
End;

procedure TfrmAltPrecoFornecedorItens.pOrdenaColunas(strNomCam: String);
  Var
    intColunas,
    intIndice,
    intPreVen: Integer;
    colCamNov,
    colCamAtu: TColumn;
Begin
  intIndice := 0;

  For intColunas := 0 To dbgItens.Columns.Count - 1 Do
    If Pos(strNomCam, dbgItens.Columns[intColunas].FieldName) > 0 Then
    Begin
      intIndice := dbgItens.Columns[intColunas].Index;
      Break;
    End;

  For intPreVen := 1 To 6 Do

    For intColunas := 0 To dbgItens.Columns.Count - 1 Do
    Begin

      If strNomCam + IntToStr(intPreVen) = dbgItens.Columns[intColunas].FieldName Then
      Begin
        colCamAtu := dbgItens.Columns[intColunas];
        colCamNov := fRetColuna(dbgItens.Columns[intColunas].FieldName + '_NOV');

        If Assigned(colCamNov) Then
        Begin
          colCamAtu.Index := intIndice;
          colCamNov.Index := colCamAtu.Index + 1;
          intIndice := Succ(colCamNov.Index);
        End;

        Break;
      End;

    End;

End;

procedure TfrmAltPrecoFornecedorItens.pAtualizaTabela;
  Var
    intContador: Integer;
    intTamMat: Integer;
    fldCampo: TField;
    fldCampoNovo: TField;
begin
  dbgItens.Columns.Clear;
  pAdicionaColuna('Empresa',    'ITE_CODEMP');
  pAdicionaColuna('Grupo',      'ITE_CODGRU');
  pAdicionaColuna('Código',     'ITE_CODITE');
  pAdicionaColuna('Descrição',  'ITE_DESITE');
  pAdicionaColuna('Fornecedor', 'ITE_CODFOR');
  If blntabPrd Then
  Begin
    pAdicionaColuna('Tab. Fornecedor', 'ITE_CODTAB');
  End;

  intTamMat := Length(arrCamposGrid);

  For intContador := 0 To intTamMat -1 Do
  Begin

    If (Not fEmptyStr(arrCamposGrid[intContador].strNomCam)) Then
    Begin
      pAdicionaColuna(arrCamposGrid[intContador].strDesAbr, arrCamposGrid[intContador].strNomCam);
      pAdicionaColuna(arrCamposGrid[intContador].strDesAbr + '(NOVO)', arrCamposGrid[intContador].strNomCam + '_NOV');
    End;

  End;

  If blnTabPrd Then
  Begin
    If intOpcAlt = 0 Then
      pOrdenaColunas('ITE_PREVE')
    Else
      pOrdenaColunas('ITE_MARBR');
  End;

  With dtsItens.DataSet Do
  Begin

    First;

    For intContador := 0 To intTamMat-1 Do
    Begin

      If (not fEmptyStr(arrCamposGrid[intContador].strDesAbr)) Then
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

procedure TfrmAltPrecoFornecedorItens.pCopiaCamposGrid(
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

procedure TfrmAltPrecoFornecedorItens.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaTabela;

  strUsaPreMat := fRetEmpresasUsamPrecoMatriz;
end;

procedure TfrmAltPrecoFornecedorItens.btnMarTodClick(Sender: TObject);
Var
  blnMarDes: Boolean;
begin
  inherited;

  blnMarDes := (Sender = btnMarTod);

  If dtsItens.DataSet.IsEmpty Then
    Exit;

  dtsItens.DataSet.First;
  While Not dtsItens.DataSet.Eof Do
  Begin
    pMarcaItem(blnMarDes);
    dtsItens.Dataset.Next;
  End;
  dtsItens.DataSet.First;

end;

procedure TfrmAltPrecoFornecedorItens.btnVoltarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoFornecedorItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  dbgItens.DefaultDrawing := False;

  If Not dtsItens.DataSet.Active Then
    Exit;

  If dtsItens.DataSet.FieldByName('ITE_MARDES').AsString = 'M' Then
    dbgItens.Canvas.Font.Color := clBlue;

  If Pos('_NOV', Column.FieldName) > 0 Then
  Begin
    Column.Color := clSilver;
  End
  Else
  Begin
    Column.Color := clWhite;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  dbgItens.DefaultDrawing := True;
end;

procedure TfrmAltPrecoFornecedorItens.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaItem;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F3) Then
  Begin
    btnMarTodClick(btnMarTod);
  End
  Else If (Key = VK_F4) Then
  Begin
    btnMarTodClick(btnDesTod);
  End
  Else If (Key = VK_Escape) Then
  Begin
    btnVoltar.Click;
  End;
end;

procedure TfrmAltPrecoFornecedorItens.pSelecionaItem;
begin
  pMarcaItem(dtsItens.DataSet.FieldByName('ITE_MARDES').AsString <> 'M');
end;

procedure TfrmAltPrecoFornecedorItens.pMarcaItem(blnMarcar: Boolean);
begin
  With dtsItens.DataSet Do
  Begin
    Edit;
    FieldByName('ITE_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    Post;
  End;
end;

function TfrmAltPrecoFornecedorItens.fAtualizaIteger: Boolean;
Begin
  Result := False;

  If Not blnTabPrd Then
    Exit;

  Result := (dtsItens.DataSet.FieldByName('UPDATE_ITEGER1').AsString = 'S') Or
            (dtsItens.DataSet.FieldByName('UPDATE_ITEGER2').AsString = 'S') Or
            (dtsItens.DataSet.FieldByName('UPDATE_ITEGER3').AsString = 'S') Or
            (dtsItens.DataSet.FieldByName('UPDATE_ITEGER4').AsString = 'S') Or
            (dtsItens.DataSet.FieldByName('UPDATE_ITEGER5').AsString = 'S') Or
            (dtsItens.DataSet.FieldByName('UPDATE_ITEGER6').AsString = 'S') Or
            (dtsItens.DataSet.FieldByName('UPDATE_ITEGER7').AsString = 'S');



End;

function TfrmAltPrecoFornecedorItens.fAtualizaItegerCustos: Boolean;
Begin
  Result := False;

  If Not blnTabPrd Then
    Exit;

  Result := (dtsItens.DataSet.FieldByName('UPDATE_ITEGER' + fRetPrimeiraTabPrecoAtiva.ToString()).AsString = 'S');
End;

function TfrmAltPrecoFornecedorItens.fAtualizaMargemPrecoVendaIteger(strNomCam: String): Boolean;
Begin
  Result := False;

  If (Pos('ITE_MARBR', strNomCam) = 0) And (Pos('ITE_PREVE', strNomCam) = 0) Then
    Exit;

  If Not CharInSet(RightStr(strNomCam, 1)[1], ['1'..'7']) Then
    Exit;

  Result := (dtsItens.DataSet.FieldByName('UPDATE_ITEGER' + RightStr(strNomCam, 1)).AsString = 'S');
End;

function TfrmAltPrecoFornecedorItens.fConfirmaItens: Boolean;
  Var
    intContReg: Integer;
    strUpdCadite,
    strUpdItefor,
    strUpdIteger,
    strUpdItegerAbf: String;
    strUpdTabDet: String;
    intContador: Integer;
    intTamMat: Integer;
    intTabPrecoAtu: integer;
//    intTabPre: Integer;

    fldCampo: TField;
    fldCampoNovo: TField;

    qryIteger,
    qryGenEmp: TUniQuery;
    qryGenTmp: TUniQuery;

    stlEmpFilial: TStringList;
    strEmpresas: String;

//    fltPreVen,
//    fltMarBru,
//    fltValor,
    fltMarBruIteFor,
    fltPreVenIteFor,
    fltPreCus: Double;

    strAgrupadorPreAlt: String;
    blnAtuItefor, blnAtuTabDet, blnAtuCadIte: Boolean;
begin
  qryGenEmp := fCriaQuery;
  qryGenTmp := fCriaQuery;
  qryIteger := fCriaQuery;
  qryIteger.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';

  stlEmpFilial := TStringList.Create;
  fRetEmpresasUsamPrecoMatriz(stlEmpFilial);
  strEmpresas := fCommaText(stlEmpFilial, True);

  pPreAltDefineVariaveisAltPre(fNow, 'TABELA PREÇOS FORNECEDOR', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

  Result    := True;

  {*****************************************}
  {* SELECIONA SOMENTE ITENS MARCADOS      *}
  {**************************************MV*}
  With dtsItens.DataSet Do
  Begin
    DisableControls;
    Filter := '(ITE_MARDES = ''M'')';
    Filtered := True;
    TUniClientDataSet(dtsItens.DataSet).IndexFieldNames := 'ORDEMP;ITE_CODITE';
    First;
    pgbProBar.Visible := True;
    pgbProBar.Max := RecordCount;

    intContReg := 0;
    If Assigned(lblContador) Then
    Begin
      lblContador.Caption :=  IntToStr(intContReg) + ' / ' + IntToStr(pgbProBar.Max);
      Application.ProcessMessages;
    End;

    blnAtuTabDet := False;
    blnAtuItefor := False;
    blnAtuCadIte := False;

    Try

      While Not Eof Do
      Begin
        intTamMat := Length(arrCamposGrid);

        strUpdTabDet := '';
        strUpdTabDet := strUpdTabDet + 'UPDATE   ';
        strUpdTabDet := strUpdTabDet + '  TABDET D ';
        strUpdTabDet := strUpdTabDet + 'SET ';

        strUpdItefor := '';
        strUpdItefor := strUpdItefor + 'UPDATE   ';
        strUpdItefor := strUpdItefor + '  ITEFOR ';
        strUpdItefor := strUpdItefor + 'SET ';

        strUpdCadite := '';
        strUpdCadite := strUpdCadite + 'UPDATE   ';
        strUpdCadite := strUpdCadite + '  CADITE ';
        strUpdCadite := strUpdCadite + 'SET ';

        If fAtualizaIteger Then
        Begin

          If (Not VS_blnPreAltViaTrigger) Then
          Begin
            qryIteger.Close;
            qryIteger.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
            qryIteger.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
            qryIteger.Open;
            qryIteger.Edit;
            qryIteger.FieldByName('ITE_PREALT').AsString := strAgrupadorPreAlt;
          End;

          strUpdIteger := '';
          strUpdIteger := strUpdIteger + 'UPDATE   ';
          strUpdIteger := strUpdIteger + '  ITEGER ';
          strUpdIteger := strUpdIteger + 'SET ';
        End;

        fltPreVenIteFor := 0;
        fltMarBruIteFor := 0;

        For intContador := 0 To intTamMat -1 Do
        Begin

          If Not fEmptyStr(arrCamposGrid[intContador].strNomCam) Then
          Begin

            fldCampo     := FieldByName(arrCamposGrid[intContador].strNomCam);
            fldCampoNovo := FieldByName(arrCamposGrid[intContador].strNomCam + '_NOV');

            If (fAtualizaItegerCustos And (Pos(arrCamposGrid[intContador].strNomCam, STR_CAMPOS_CUSTOS_ALTPRE_ITEFOR + 'ITE_PRECUS_') > 0)) Or
               fAtualizaMargemPrecoVendaIteger(arrCamposGrid[intContador].strNomCam) Then
            Begin
              strUpdIteger := strUpdIteger + ' ' + fldCampo.FieldName + ' = ';
              If blnTabPrd And (fldCampo.FieldName = 'ITE_PRECUS') Then
              Begin
                strUpdIteger := strUpdIteger + AnsiReplaceStr(dtsItens.DataSet.FieldByName('ITE_PRECUS'+IntToStr(fRetPrimeiraTabPrecoAtiva)+'_NOV').AsString, ',', '.');
              End
              Else
              begin
                If fldCampo.DataType = ftString Then
                  strUpdIteger := strUpdIteger + QuotedStr(fldCampoNovo.AsString)
                Else
                  strUpdIteger := strUpdIteger + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');
              End;

              If intContador < intTamMat -1 Then
                strUpdIteger := strUpdIteger + ',';

              If Assigned(qryIteger.FindField(arrCamposGrid[intContador].strNomCam)) Then
                qryIteger.FieldByName(arrCamposGrid[intContador].strNomCam).Value := fldCampoNovo.Value;
            End;

            If (arrCamposGrid[intContador].strNomArqSec = 'ITEGER') Then
            Begin
               strUpdIteger := strUpdItefor + ' ' + fldCampo.FieldName + ' = ';
               If fldCampo.DataType = ftString Then
                 strUpdIteger := strUpdIteger + QuotedStr(fldCampoNovo.AsString);

               If intContador < intTamMat -1 Then
                 strUpdIteger := strUpdIteger + ',';
            End;

            If (arrCamposGrid[intContador].strNomArqSec = 'CADITE') Then
            Begin
              blnAtuCadIte := True;
               strUpdCadite := strUpdCadite + ' ' + fldCampo.FieldName + ' = ';
               If fldCampo.DataType = ftString Then
                 strUpdCadite := strUpdCadite + QuotedStr(fldCampoNovo.AsString);

               If intContador < intTamMat -1 Then
                 strUpdCadite := strUpdCadite + ',';
            End;

            If (arrCamposGrid[intContador].strNomArq = 'ITEFOR')  Then
            Begin
              blnAtuIteFor := True;
              strUpdItefor := strUpdItefor + ' ' + fldCampo.FieldName + ' = ';
              If fldCampo.DataType = ftString Then
                strUpdItefor := strUpdItefor + QuotedStr(fldCampoNovo.AsString)
              Else
                strUpdItefor := strUpdItefor + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');
              If intContador < intTamMat -1 Then
                strUpdItefor := strUpdItefor + ',';

              If (arrCamposGrid[intContador].strNomCam = 'TFO_PRDGRU')  Or (arrCamposGrid[intContador].strNomArqSec = 'CADITE') then
              Begin
                blnAtuCadIte := True;
                If (arrCamposGrid[intContador].strNomCam = 'TFO_PRDGRU') Then
                begin
                  strUpdCadite := strUpdCadite + 'ITE_PRDGRU = ' +  QuotedStr(fldCampoNovo.AsString);
                  If intContador < intTamMat -1 Then
                    strUpdCadite := strUpdCadite + ',';

                End;
              End;


            End;

            If (arrCamposGrid[intContador].strNomArq = 'TABDET')  Then
            Begin
              blnAtuTabDet := True;

              strUpdTabDet := strUpdTabDet + ' ' + fldCampo.FieldName + ' = ';

              If fldCampo.DataType = ftString Then
                strUpdTabDet := strUpdTabDet + QuotedStr(fldCampoNovo.AsString)
              Else
                strUpdTabDet := strUpdTabDet + AnsiReplaceStr(fldCampoNovo.AsString, ',', '.');

              If blnTabPrd And (arrCamposGrid[intContador].strNomCam = 'ITE_PRECUS') Then
              Begin

                If intOpcAlt = 0 Then
                Begin // ATUALIZA PREÇO DE VENDA
                  Raise Exception.Create('Essa Rotina não está preparada para atualizar preço de venda!');

                End Else
                Begin // ATUALIZA MARGEM

                  If FieldByName('ITE_PREVEN').AsFloat > 0 Then
                  Begin
                    strUpdTabDet := strUpdTabDet + ',';

                    fltPreCus := fStrToFloat(fldCampoNovo.AsString);

                    strUpdTabDet := strUpdTabDet + ' D.ITE_MARBRU = :MARBRU ';

                    fltMarBruIteFor := fCalculaPrecoVenda(2,
                                                          fltPreCus,
                                                          FieldByName('ITE_PREVEN').AsFloat,
                                                          FieldByName('ITE_MARBRU').AsFloat,
                                                          FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                                          FieldByName('ITE_IMPFED_NOV').AsFloat,
                                                          FieldByName('ITE_DESOPE_NOV').AsFloat,
                                                          FieldByName('ITE_COMTBL_NOV').AsFloat);
                  End;

                End;

              End;

              If intContador < intTamMat -1 Then
                strUpdTabDet := strUpdTabDet + ',';

            End

           
          End;

        End;

        If Not Result Then
          Break;

        If RightStr(strUpdTabDet, 1) = ',' Then
          strUpdTabDet := Copy(strUpdTabDet, 1, Length(strUpdTabDet)-1);

        strUpdTabDet := strUpdTabDet + ' WHERE ';

        If blnTabPrd Then
          strUpdTabDet := strUpdTabDet + ' ITE_CODEMP = :CODEMP '
        Else
          strUpdTabDet := strUpdTabDet + ' ITE_CODEMP IN (' + strEmpresas  + ')';

        strUpdTabDet := strUpdTabDet + '   AND ITE_CODITE = :CODITE ';
        strUpdTabDet := strUpdTabDet + '   AND ITE_CODTAB = :CODTAB ';
        strUpdTabDet := strUpdTabDet + '   AND ITE_CODFOR = :CODFOR ';

        If blnAtuTabDet Then
        Begin
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdTabDet);

          If blnTabPrd Then
          Begin
            If qryGenTmp.Params.FindParam('MARBRU') <> Nil Then
              qryGenTmp.ParamByName('MARBRU').AsFloat := fltMarBruIteFor;

            If qryGenTmp.Params.FindParam('PREVEN') <> Nil Then
              qryGenTmp.ParamByName('PREVEN').AsFloat := fltPreVenIteFor;

              qryGenTmp.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
          End;

          qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          qryGenTmp.ParamByName('CODFOR').AsString := FieldByName('ITE_CODFOR').AsString;
          qryGenTmp.ParamByName('CODTAB').AsString := FieldByName('ITE_CODTAB').AsString;
          qryGenTmp.ExecSQL;
          qryGenTmp.Close;

          If fAtualizaIteger Then
          Begin
            If RightStr(strUpdIteger, 1) = ',' Then
              strUpdIteger := Copy(strUpdIteger, 1, Length(strUpdIteger)-1);

            strUpdIteger := strUpdIteger + ' WHERE ';
            strUpdIteger := strUpdIteger + '       ITE_CODEMP = :CODEMP ';
            strUpdIteger := strUpdIteger + '   AND ITE_CODITE = :CODITE ';

            qryGenTmp.Close;
            qryGenTmp.SQL.Clear;
            qryGenTmp.SQL.Add(strUpdIteger);

            qryGenTmp.ParamByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString;
            qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
            qryGenTmp.ExecSQL;

            If (Not VS_blnPreAltViaTrigger) Then
              Result := fGravaAlteracaoPreco(qryIteger);

            If Not Result Then
              Break;

            qryGenTmp.Close;
          End;


        End;

        If blnAtuIteFor Then
        Begin
          If RightStr(strUpdItefor, 1) = ',' Then
            strUpdItefor := Copy(strUpdItefor, 1, Length(strUpdItefor)-1);

          strUpdItefor := strUpdItefor + ' WHERE ';

          strUpdItefor := strUpdItefor + '       ITE_CODITE = :CODITE ';
          strUpdItefor := strUpdItefor + '   AND ITE_CODTAB = :CODTAB ';
          strUpdItefor := strUpdItefor + '   AND ITE_CODFOR = :CODFOR ';


          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdItefor);

          qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          qryGenTmp.ParamByName('CODFOR').AsString := FieldByName('ITE_CODFOR').AsString;
          qryGenTmp.ParamByName('CODTAB').AsString := FieldByName('ITE_CODTAB').AsString;
          qryGenTmp.ExecSQL;
        End;

        If blnAtuCadIte Then
        Begin
          If RightStr(strUpdCadIte, 1) = ',' Then
            strUpdCadIte := Copy(strUpdCadIte, 1, Length(strUpdCadIte)-1);
          strUpdCadIte := strUpdCadIte + ' WHERE ITE_CODFOR = :CODFOR ';
          strUpdCadIte := strUpdCadIte + '   AND ITE_CODITE = :CODITE ';
          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strUpdCadIte);
          qryGenTmp.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          qryGenTmp.ParamByName('CODFOR').AsString := FieldByName('ITE_CODFOR').AsString;
          qryGenTmp.ExecSQL;

        End;

        If blnTabPrD then
        Begin
          For intTabPrecoAtu := 1 To 7 do
          Begin
            If Assigned(dtsItens.DataSet.FindField('ITE_ICMSAI'+intTabPrecoAtu.ToString)) Then
            Begin
              pSalvaDetCus(dtsItens.DataSet.FieldByName('INCDET').AsString,
                           intTabPrecoAtu,
                           dtsItens.DataSet.FieldByName('ITE_ICMSAI'+intTabPrecoAtu.ToString+'_NOV').AsFloat,
                           dtsItens.DataSet.FieldByName('ITE_DESOPE'+intTabPrecoAtu.ToString+'_NOV').AsFloat,
                           dtsItens.DataSet.FieldByName('ITE_OUTVAL'+intTabPrecoAtu.ToString+'_NOV').AsFloat,
                           dtsItens.DataSet.FieldByName('ITE_MARBR'+intTabPrecoAtu.ToString+'_NOV').AsFloat,
                           dtsItens.DataSet.FieldByName('ITE_PREVE'+intTabPrecoAtu.ToString+'_NOV').AsFloat);
            End;
          End;
        End;


        If Assigned(lblContador) Then
        Begin
          inc(intContReg);
          lblContador.Caption :=  IntToStr(intContReg) + ' / ' + IntToStr(pgbProBar.Max);
        End;

        Application.ProcessMessages;
        Next;
      End;

      pgbProBar.Position := 0;
      pgbProBar.Visible := False;

      Filtered := False;
      EnableControls;

    Except
      On E: Exception Do
      Begin
        Filtered := False;
        EnableControls;
        Result := False;
        pMensagensErro(E.Message, '[fConfirmaItens]');
      End;

    End;
  End;

  FreeAndNil(qryIteger);
  FreeAndNil(qryGenEmp);
  FreeAndNil(qryGenTmp);
end;

procedure TfrmAltPrecoFornecedorItens.pSalvaDetCus(strAutoIncrem: String; Tabela: integer;
fltIcmSai, fltDesOpe, fltOutVal, fltMarBru, fltPreven: Double);
var qryComand: TUniQuery;

begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('REPLACE INTO DETCUS (DET_SEQDET, DET_TABELA, DET_ICMSAI, DET_DESOPE, DET_OUTVAL,DET_MARBRU,DET_PREVEN ) VALUES (:SEQDET, :TABELA, :ICMSAI, :DESOPE, :OUTVAL,:MARBRU, :PREVEN);');
    qryComand.ParamByName('SEQDET').Value :=  strAutoIncrem;
    qryComand.ParamByName('TABELA').Value :=  Tabela;
    qryComand.ParamByName('ICMSAI').Value :=  fltIcmSai;
    qryComand.ParamByName('DESOPE').Value :=  fltDesOpe;
    qryComand.ParamByName('OUTVAL').Value :=  fltOutVal;
    qryComand.ParamByName('MARBRU').Value :=  fltMarBru;
    qryComand.ParamByName('PREVEN').Value :=  fltPreven;
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
End;



Function TfrmAltPrecoFornecedorItens.fGravaAlteracaoPreco(qryUpdateIteger: TUniQuery): Boolean;
Begin
  Result := fGravaPreAlt(qryUpdateIteger.FieldByName('ITE_CODITE').AsString,

                         qryUpdateIteger.FieldByName('ITE_PRECUS').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PRECUS').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PREVE1').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PREVE1').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_MARBR1').OldValue,
                         qryUpdateIteger.FieldByName('ITE_MARBR1').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PREVE2').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PREVE2').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_MARBR2').OldValue,
                         qryUpdateIteger.FieldByName('ITE_MARBR2').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PREVE3').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PREVE3').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_MARBR3').OldValue,
                         qryUpdateIteger.FieldByName('ITE_MARBR3').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PREVE4').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PREVE4').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_MARBR4').OldValue,
                         qryUpdateIteger.FieldByName('ITE_MARBR4').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PREVE5').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PREVE5').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_MARBR5').OldValue,
                         qryUpdateIteger.FieldByName('ITE_MARBR5').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PREVE6').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PREVE6').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_MARBR6').OldValue,
                         qryUpdateIteger.FieldByName('ITE_MARBR6').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PREVE7').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PREVE7').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_MARBR7').OldValue,
                         qryUpdateIteger.FieldByName('ITE_MARBR7').AsFloat,

                         qryUpdateIteger.FieldByName('ITE_PRECOM').OldValue,
                         qryUpdateIteger.FieldByName('ITE_PRECOM').AsFloat,

                         'TABELA PREÇOS FORNECEDOR',

                         Nil,
                         '',
                         strLoginUsuarioLogado);
  qryUpdateIteger.Cancel;
End;

Function TfrmAltPrecoFornecedorItens.fConfirma: Boolean;
  Var
    blnIteMar: Boolean;
Begin
  Try
    Result := False;

    blnIteMar := False;
    dtsItens.DataSet.First;
    While Not dtsItens.DataSet.Eof Do
    Begin
      If dtsItens.DataSet.FieldByName('ITE_MARDES').AsString = 'M' Then
      Begin
        blnIteMar := True;
        Break;
      End;
      dtsItens.Dataset.Next;
    End;

    If Not (blnIteMar) Then
    Begin
      fMensagem('', 'Não há itens marcados para serem alterados!', ['&O k']);
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

    Result := blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TfrmAltPrecoFornecedorItens.fConfirma]');
    End;
  End;
End;

procedure TfrmAltPrecoFornecedorItens.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
     Exit;

  If fMensagem('', 'Confirma Itens?', ['&Sim', '&Não']) = 2 Then
  Begin
    pSetFocus(Self);
    Exit;
  End;

  fConfirma;
end;

procedure TfrmAltPrecoFornecedorItens.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  qryGenIte := fCriaQuery(Self);

  pgbProBar    := pgbProgresso;
  lblContador  := Nil;
end;

procedure TfrmAltPrecoFornecedorItens.dbgItensDblClick(Sender: TObject);
  Var
    Key: Word;
    State: TShiftState;
begin
  inherited;
  Key := VK_Return;
  dbgItensKeyDown(Sender, Key, State);
end;

end.


