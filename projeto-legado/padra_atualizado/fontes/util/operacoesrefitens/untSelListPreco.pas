unit untSelListPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untPaiOrdena,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider;

type
  TfrmSelListPreco = class(TfrmPaiOrdena)
    btnGravar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    intConfirma: Integer;
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
  end;

var
  frmSelListPreco: TfrmSelListPreco;

implementation

uses untFuncoesSimples, StrUtils, System.UITypes;

{$R *.dfm}

function TfrmSelListPreco.fAbreConsulta(blnLike: Boolean): Boolean;
  Var
    intIndex: Integer;

    function fSoma(Var intVal: Integer; intSoma: Integer = 1): Integer;
    Begin
      intVal := intVal + intSoma;
      Result := intVal;
    End;
begin

  Result := False;

  If cdsConsulta.IsEmpty Then
    Result := inherited fAbreConsulta(blnLike);

  If Result Then
  Begin
    dbgConsulta.Columns[0].Title.Caption := 'Código';
    dbgConsulta.Columns[1].Title.Caption := 'Descrição';
    dbgConsulta.Columns[2].Title.Caption := 'Referencia';

    intIndex := 2;
    If VS_strTabPrc[1] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Title.Caption := 'Tabela 1';
    If VS_strTabPrc[2] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Title.Caption := 'Tabela 2';
    If VS_strTabPrc[3] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Title.Caption := 'Tabela 3';
    If VS_strTabPrc[4] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Title.Caption := 'Tabela 4';
    If VS_strTabPrc[5] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Title.Caption := 'Tabela 5';
    If VS_strTabPrc[6] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Title.Caption := 'Tabela 6';
    If VS_strTabPrc[7] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Title.Caption := 'Tabela 7';

    dbgConsulta.Columns[fSoma(intIndex)].Visible := False;

    intIndex := 2;
    If VS_strTabPrc[1] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Alignment := taCenter;
    If VS_strTabPrc[2] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Alignment := taCenter;
    If VS_strTabPrc[3] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Alignment := taCenter;
    If VS_strTabPrc[4] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Alignment := taCenter;
    If VS_strTabPrc[5] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Alignment := taCenter;
    If VS_strTabPrc[6] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Alignment := taCenter;
    If VS_strTabPrc[7] = 'S' Then dbgConsulta.Columns[fSoma(intIndex)].Alignment := taCenter;    

    dbgConsulta.Columns[0].Width := 55;
    dbgConsulta.Columns[1].Width := 300;
    dbgConsulta.Columns[2].Width := 140;
  End;

end;

function TfrmSelListPreco.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_CODITE, ';
  strSQL := strSQL + '   ITE_DESITE, ';
  strSQL := strSQL + '   ITE_REFERE, ';

  If VS_strTabPrc[1] = 'S' Then
    strSQL := strSQL + ' IFNULL((SELECT IF(LIS_CODTAB = 1, "S", "N") FROM IMPLIS B WHERE B.LIS_CODITE = A.LIS_CODITE AND B.LIS_CODEMP = A.LIS_CODEMP AND B.LIS_CODTAB = 1), "N") AS TAB001, ';

  If VS_strTabPrc[2] = 'S' Then
    strSQL := strSQL + ' IFNULL((SELECT IF(LIS_CODTAB = 2, "S", "N") FROM IMPLIS C WHERE C.LIS_CODITE = A.LIS_CODITE AND C.LIS_CODEMP = A.LIS_CODEMP AND C.LIS_CODTAB = 2), "N") AS TAB002, ';

  If VS_strTabPrc[3] = 'S' Then
    strSQL := strSQL + ' IFNULL((SELECT IF(LIS_CODTAB = 3, "S", "N") FROM IMPLIS D WHERE D.LIS_CODITE = A.LIS_CODITE AND D.LIS_CODEMP = A.LIS_CODEMP AND D.LIS_CODTAB = 3), "N") AS TAB003, ';

  If VS_strTabPrc[4] = 'S' Then
    strSQL := strSQL + ' IFNULL((SELECT IF(LIS_CODTAB = 4, "S", "N") FROM IMPLIS E WHERE E.LIS_CODITE = A.LIS_CODITE AND E.LIS_CODEMP = A.LIS_CODEMP AND E.LIS_CODTAB = 4), "N") AS TAB004, ';

  If VS_strTabPrc[5] = 'S' Then
    strSQL := strSQL + ' IFNULL((SELECT IF(LIS_CODTAB = 5, "S", "N") FROM IMPLIS F WHERE F.LIS_CODITE = A.LIS_CODITE AND F.LIS_CODEMP = A.LIS_CODEMP AND F.LIS_CODTAB = 5), "N") AS TAB005, ';

  If VS_strTabPrc[6] = 'S' Then
    strSQL := strSQL + ' IFNULL((SELECT IF(LIS_CODTAB = 6, "S", "N") FROM IMPLIS G WHERE G.LIS_CODITE = A.LIS_CODITE AND G.LIS_CODEMP = A.LIS_CODEMP AND G.LIS_CODTAB = 6), "N") AS TAB006, ';

  If VS_strTabPrc[7] = 'S' Then
    strSQL := strSQL + ' IFNULL((SELECT IF(LIS_CODTAB = 7, "S", "N") FROM IMPLIS G WHERE G.LIS_CODITE = A.LIS_CODITE AND G.LIS_CODEMP = A.LIS_CODEMP AND G.LIS_CODTAB = 7), "N") AS TAB007, ';

  strSQL := strSQL + '   CADITE.AUTOINCREM ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE ';
  strSQL := strSQL + '   LEFT JOIN IMPLIS A ON ITE_CODITE = LIS_CODITE AND LIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + ' GROUP BY ITE_CODITE ';

  Result := strSQL;
end;

procedure TfrmSelListPreco.FormCreate(Sender: TObject);
begin
  inherited;
  blnTemSelecao := False;
  blnSelecionaComEnter:= False;
  blnSempreRelerBanco := False;

  intConfirma := -1;
end;

procedure TfrmSelListPreco.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If Column.Field.Text = 'S' Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
        Font.Style := [];
      End
      Else
      Begin
        Font.Color := clGreen;
        Font.Style := [fsBold];
      End;

    End
    Else If Column.Field.Text = 'N' Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
        Font.Style := [];
      End
      Else
      Begin
        Font.Color := clRed;
        Font.Style := [fsBold];
      End;

    End;

    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmSelListPreco.FormShow(Sender: TObject);
begin
  inherited;
  fAbreConsulta(TRUE);
end;

procedure TfrmSelListPreco.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: Begin
                 If dbgConsulta.SelectedField.Index > 2 Then
                 Begin
                   cdsConsulta.Edit;
                   dbgConsulta.SelectedField.Value := IIF(dbgConsulta.SelectedField.Value = 'S','N','S');
                   cdsConsulta.Post;
                 End;
               End;
  End;

end;

procedure TfrmSelListPreco.btnGravarClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    intContador: Integer;
begin
  inherited;

  cdsConsulta.DisableControls;
  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      qryGen := fCriaQuery;
      
      cdsConsulta.Filtered := False;
      cdsConsulta.Filter := '';

      If VS_strTabPrc[1] = 'S' Then
        cdsConsulta.Filter := 'TAB001 = ' + QuotedStr('S') + ' OR ';

      If VS_strTabPrc[2] = 'S' Then
        cdsConsulta.Filter := cdsConsulta.Filter + 'TAB002 = ' + QuotedStr('S') + ' OR ';

      If VS_strTabPrc[3] = 'S' Then
        cdsConsulta.Filter := cdsConsulta.Filter + 'TAB003 = ' + QuotedStr('S') + ' OR ';

      If VS_strTabPrc[4] = 'S' Then
        cdsConsulta.Filter := cdsConsulta.Filter + 'TAB004 = ' + QuotedStr('S') + ' OR ';

      If VS_strTabPrc[5] = 'S' Then
        cdsConsulta.Filter := cdsConsulta.Filter + 'TAB005 = ' + QuotedStr('S') + ' OR ';

      If VS_strTabPrc[6] = 'S' Then
        cdsConsulta.Filter := cdsConsulta.Filter + 'TAB006 = ' + QuotedStr('S') + ' OR ';

      If VS_strTabPrc[7] = 'S' Then
        cdsConsulta.Filter := cdsConsulta.Filter + 'TAB007 = ' + QuotedStr('S') + ' OR ';

      cdsConsulta.Filter := LeftStr(cdsConsulta.Filter, Length(cdsConsulta.Filter)-3);
      cdsConsulta.Filtered := True;

      If Not cdsConsulta.IsEmpty Then
      Begin

        fStartTransaction;

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add('DELETE FROM IMPLIS WHERE LIS_CODEMP = :CODEMP');
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryGen.ExecSQL;

        cdsConsulta.First;
        While Not cdsConsulta.Eof Do
        Begin

          {*******************************************}
          {* QUANTIDADE DE TABELAS DE PREÇOS         *}
          {****************************************AF*}
          For intContador := 1 To Length(VS_strTabPrc) Do
          Begin

            If VS_strTabPrc[intContador] = 'N' Then
              Continue;

            If cdsConsulta.FieldByName('TAB' + fStrZero(intContador, 3)).AsString <> 'S' Then
              Continue;

            qryGen.Close;
            qryGen.SQL.Clear;
            qryGen.SQL.Add('INSERT INTO IMPLIS ( ');
            qryGen.SQL.Add('  AUTOINCREM, ');
            qryGen.SQL.Add('  LIS_CODITE, ');
            qryGen.SQL.Add('  LIS_CODEMP, ');
            qryGen.SQL.Add('  LIS_CODTAB  ');
            qryGen.SQL.Add('  ) VALUES (  ');
            qryGen.SQL.Add('  :AUTINC,    ');
            qryGen.SQL.Add('  :CODITE,    ');
            qryGen.SQL.Add('  :CODEMP,    ');
            qryGen.SQL.Add('  :CODTAB)    ');

            qryGen.ParamByName('AUTINC').AsString  := fRetAutoIncrem('IMPLIS', VS_strCodEmp);
            qryGen.ParamByName('CODITE').AsString  := cdsConsulta.FieldByName('ITE_CODITE').AsString;
            qryGen.ParamByName('CODEMP').AsString  := VS_strCodEmp;
            qryGen.ParamByName('CODTAB').AsInteger := intContador;

            qryGen.ExecSQL;
          End;

          cdsConsulta.Next;
        End;

        fCommit;
        fMensagem('','Dados gravados com sucesso!',['&OK']);

      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'[frmSelListPreco - btnGravarClick]');
      End;
    End;

    FreeAndNil(qryGen);
  End
  Else
    InterlockedDecrement(intConfirma);

  Close;
end;

procedure TfrmSelListPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: Begin
              btnGravar.Click;
              Key := 0;
            End;
  End;

end;

end.
