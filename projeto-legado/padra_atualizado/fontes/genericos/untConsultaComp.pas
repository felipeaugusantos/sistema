unit untConsultaComp;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, StrUtils, BitBtnLockedIncrem, MemDS, DBAccess, untConsulta ;

type
  TAfterOpen = procedure (DataSet: TDataSet) of object;

  TfrmConsultaComp = class(TfrmConsulta)
    pnlLegendaCadCli: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    lblLegenda: TLabel;
    lblPendencia: TLabel;
    lblInativo: TLabel;
    btnExecutaTarefa: TBitBtnLocked;
    chkConsContida: TCheckBox;
    procedure edtFiltro1Change(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure edtFiltro1KeyPress(Sender: TObject; var Key: Char);
    procedure edtFiltro2KeyPress(Sender: TObject; var Key: Char);
    procedure edtFiltro3KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure pEscondeAutoIncremento(qryConsulta: TUniQuery);
    procedure pMarDesRegistro;
    procedure pMarDesTodosRegistros(strOpcao: String);
    procedure pVoltaOrdemGrid;
  protected
    {*****************************************}
    {* CASO ESSA VARIAVEL SEJA TRUE, O GRID  *}
    {* VOLTA A CONEXÃO COM O BANCO E AS      *}
    {* INFORMAÇÕES VOLTAM A SER EXIBIDAS, SE *}
    {* NÃO, ESSA RESPOSABILIDADE FICA A CARGO*}
    {* DO PROGRAMADOR                        *}
    {**************************************MV*}
    blnRestauraGrid: Boolean;

    strUltimaPesquisa: String;

    {*****************************************}
    {*    FUNÇÕES E PROCEDURES QUE SERÃO     *}
    {*        ---> SOBRESCRITAS <---         *}
    {**************************************MV*}
    procedure pAtuIndice(intIndice:Integer); override;
    procedure pSetaUltimaPesquisa;
    procedure pInicializaUltimaPesquisa;

    Function fMontaUltimaPesquisa(strIndice1, strIndice2, strIndice3: String): String;
    function fRetOperador(strNomeCampo: String): String; override;
    function fGetSQLTextoContido(strCampo, strTexto: String): String;
    function fMontaSQL: String; overload; virtual;
    function fPodeDigitar(strTexto: String): Boolean;
  public
    { Public declarations }
    {*****************************************}
    {* VARIAVEL QUE RECEBE O SQL EXTERNO     *}
    {**************************************MV*}
    strSQLConsulta: String;
    strSQLConsultaOri: String;
    strOrderOpc   : String;

    strSQLInners    : String;
    strSQLCamposInners: String;

    stlCamposCompletaComZeros: TStringList;

    strFiltroExtra,
    strHaving: String;

    blnMarDes       : Boolean;
    blnFiltraTecla  : Boolean;
    blnMostraTudo   : Boolean;
    blnIniciaVazio  : Boolean;
    intMinimoDigitos: Integer;
    strNomeForm     : String;
    strCampoChave   : String;
    aftAfterOpen    : TAfterOpen;
    blnCheckSaldo   : Boolean;
    blnCheckPromo   : Boolean;

    function pConsulta(lstIndice, lstDesInd: TStringList):Boolean; overload;
    function fProcessaChaveComp(strChave, strCaracter: String): arrString;

    procedure pAtuIndicePub;
    Procedure pAtualizaConsulta;
    procedure pSalvaOrdemGrid;

  end;

var
  frmConsultaComp: TfrmConsultaComp;

implementation

uses untfuncoesSimples, untModulo, untConsultas;

{$R *.dfm}

{ TfrmConsultaComp }

procedure TfrmConsultaComp.pAtuIndicePub;
begin
  pAtuIndice(lstIndices.ItemIndex);
end;

function TfrmConsultaComp.fMontaSQL: String;
  Var
    strSQL      : String;
    strSQLOrder : String;
    strOperador : String;
    strCampo    : String;
    strGroupBy  : String;
    strNomeCampo: String;
    strDesCampo : String;
    intQtdCampos: Integer;
    intIndCampo : Integer;
    blnFiltroBranco: Boolean;
begin

  blnFiltroBranco := True;

  intQtdCampos := fContaCampos(lstConInd.Strings[lstIndices.ItemIndex]);
  intIndCampo  := lstIndices.ItemIndex;

  strSQL       := strSQLConsultaOri;

  strSQL := AnsiReplaceStr(strSQL,'GROUP BY ITODAS','IGNORAR');

    If Not fEmptyStr(strHaving) Then
      strSQL := strSQL + ' HAVING ' + strHaving;

  {*****************************************}
  {* CORRIGE O PROBLEMA PARA CONSULTAS COM *}
  {* GROUP BY                              *}
  {**************************************RV*}
  If (Pos('GROUP BY', strSQL) > 0) And (Pos('UNION ALL', strSQL) = 0) Then
  Begin
    strGroupBy := Copy(strSQL, Pos('GROUP BY', strSQL), Length(strSQL));
    strSQL     := Copy(strSQL, 1, Pos('GROUP BY', strSQL) - 1);
  End;
  If (Pos('WHERE', strSQL) = 0) Then
    strSQL     := strSQL + ' WHERE 1 = 1 ';

  strSQLOrder  := fRetOrderBy(lstConInd.Strings[lstIndices.ItemIndex]);
  strDesCampo  := lstConDes.Strings[lstIndices.ItemIndex];
  strNomeCampo := lstConInd.Strings[intIndCampo];

  Case intQtdCampos Of

    {*****************************************}
    {* MONTA CLÁUSULA WHERE PARA 1 PARAMETRO *}
    {**************************************MV*}
    1:Begin
        If (Not fEmptyStr(edtFiltro1.Text)) Then
        Begin
          strSQL      := strSQL + ' AND ';
          strOperador := fRetOperador(strDesCampo);
          If strOperador = 'LIKE' Then
          Begin
            If chkConsContida.Visible And chkConsContida.Checked Then
              strSQL := strSQL + fGetSQLTextoContido(strNomeCampo, edtFiltro1.Text)
            Else
              strSQL := strSQL + strNomeCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
          End
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDAte(strNomeCampo, edtFiltro1.Text)
          Else
            strSQL := strSQL + strNomeCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;

          blnFiltroBranco := False;

        End;

      End;

    {*****************************************}
    {* MONTA CLÁUSULA WHERE PARA 2 PARAMETROS*}
    {**************************************MV*}
    2:Begin
        If (Trim(edtFiltro1.Text) <> '') Then
        Begin
          {******************************************}
          {* RETORNA A DESCRIÇÃO DO CAMPO, PARA SER *}
          {* USADO NA FUNÇAÕ 'fRetOperador'         *}
          {***************************************MV*}
          strCampo := AnsiReplaceStr(Copy(strDesCampo, 1, Pos('/', strDesCampo)-1), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)-1), '+', '');

          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
          Begin
            If chkConsContida.Visible And chkConsContida.Checked Then
              strSQL := strSQL + fGetSQLTextoContido(strCampo, edtFiltro1.Text)
            Else
              strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
          End
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro1.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;

          blnFiltroBranco := False;

        End;

        If (Trim(edtFiltro2.Text) <> '') Then
        Begin
          {******************************************}
          {* RETORNA A DESCRIÇÃO DO CAMPO, PARA SER *}
          {* USADO NA FUNÇAÕ 'fRetOperador'         *}
          {***************************************MV*}
          strCampo := AnsiReplaceStr(Copy(strDesCampo, Pos('/', strDesCampo), Length(strDesCampo)), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, Pos('+', strNomeCampo), Length(strNomeCampo)), '+', '');
          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
          Begin
            If chkConsContida.Visible And chkConsContida.Checked Then
              strSQL := strSQL + fGetSQLTextoContido(strCampo, edtFiltro2.Text)
            Else
              strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro2.Text + '%')
          End
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro2.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro2.Text;

          blnFiltroBranco := False;

        End;
      End;

    {*****************************************}
    {* MONTA CLÁUSULA WHERE PARA 3 PARAMETROS*}
    {**************************************MV*}
    3:Begin

        If (Trim(edtFiltro1.Text) <> '') Then
        Begin
          strCampo := AnsiReplaceStr(Copy(strDesCampo, 1, Pos('/', strDesCampo)-1), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)-1), '+', '');

          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
          Begin
            If chkConsContida.Visible And chkConsContida.Checked Then
              strSQL := strSQL + fGetSQLTextoContido(strCampo, edtFiltro1.Text)
            Else
              strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%');
          End
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro1.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;

          blnFiltroBranco := False;

        End;
        Delete(strNomeCampo, 1, Pos('+', strNomeCampo));
        Delete(strDesCampo, 1, Pos('/', strDesCampo));

        If (Trim(edtFiltro2.Text) <> '') Then
        Begin
          strCampo := AnsiReplaceStr(Copy(strDesCampo, 1, Pos('/', strDesCampo)), '/', '');
          strCampo := Trim(strCampo);
          strOperador := fRetOperador(strCampo);

          strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)), '+', '');

          strSQL := strSQL + ' AND ';
          If strOperador = 'LIKE' Then
          Begin
            If chkConsContida.Visible And chkConsContida.Checked Then
              strSQL := strSQL + fGetSQLTextoContido(strCampo, edtFiltro2.Text)
            Else
              strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro2.Text + '%')
          End
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro2.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro2.Text;

          blnFiltroBranco := False;

        End;
        Delete(strNomeCampo, 1, Pos('+', strNomeCampo));
        Delete(strDesCampo, 1, Pos('/', strDesCampo));

        If (edtFiltro3.Text <> '') Then
        Begin
          strSQL := strSQL + ' AND ';
          strDesCampo := Trim(strDesCampo);
          strOperador := fRetOperador(strDesCampo);

          strCampo := strNomeCampo;
          If strOperador = 'LIKE' Then
          Begin
            If chkConsContida.Visible And chkConsContida.Checked Then
              strSQL := strSQL + fGetSQLTextoContido(strCampo, edtFiltro3.Text)
            Else
              strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro3.Text + '%')
          End
          Else If strOperador = 'DATE' Then
            strSQL := strSQL + fAsDate(strCampo, edtFiltro3.Text)
          Else
            strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro3.Text;

          blnFiltroBranco := False;

        End;
      End;

  End;

  {*****************************************}
  {* CORRIGE O PROBLEMA PARA CONSULTAS COM *}
  {* GROUP BY                              *}
  {**************************************RV*}
  If Not fEmptyStr(strGroupBy) Then
    strSQL := strSQL + strGroupBy;

  strSQLConsulta := strSQL;

  If (Pos('ORDER BY', strOrderOpc) > 0) And (Pos('UNION ALL', strOrderOpc) = 0) Then
  Begin
    strSQL := strSQL + ' ' + strOrderOpc;
    strSQLOrder := '';
  End
  Else If (Pos('GROUP BY', strOrderOpc) > 0) And (Pos('UNION ALL', strOrderOpc) = 0) Then
  Begin
    strSQL := strSQL + ' ' + strOrderOpc +  ' ORDER BY ' + strSQLOrder;
  End
  Else
  Begin
    strSQL := strSQL + ' ORDER BY ' + strSQLOrder + strOrderOpc;
  End;

  {*******************************}
  {* VOLTA GROUP BY DO SUBSELECT *}
  {****************************MM*}
  strSQL         := AnsiReplaceStr(strSQL,'IGNORAR','GROUP BY ITODAS');
  strSQLConsulta := AnsiReplaceStr(strSQLConsulta,'IGNORAR','GROUP BY ITODAS');

  If (Not blnMostraTudo) And (blnFiltroBranco) Then
    strSQL := strSQL + ' LIMIT 0 ';

  Result := strSQL;
end;

procedure TfrmConsultaComp.pAtuIndice(intIndice: Integer);
  Var
    strSQL: String;
    strSQLOrder: String;
begin
  Try

    strSQLOrder := fRetOrderBy(lstConInd.Strings[intIndice]);

    If blnPrimeiraVez Then
      strSQLConsultaOri := ReplaceStr(strSQLConsulta, 'WHERE FALSE', 'WHERE TRUE');

    If (Not fEmptyStr(strUltSelect)) And (blnPrimeiraVez) Then
    Begin
      lstIndices.ItemIndex := intUltItemIndex;
      strSQL               := strUltSelect;

      If (blnIniciaVazio) Then
      Begin
        If (RightStr(Trim(strSQL), 7) <> 'LIMIT 0') Then
          strSQL := strSQL + ' LIMIT 0 ';
      End;

    End
    Else
    Begin
      If (Pos('ORDER BY', strOrderOpc) > 0) Then
      Begin
        strSQL := strSQLConsulta + ' ' + strOrderOpc;
        strSQLOrder := '';
      End
      Else If (Pos('GROUP BY', strOrderOpc) > 0) Then
      Begin
        strSQL := strSQLConsulta + ' ' + strOrderOpc +  ' ORDER BY ' + strSQLOrder;
      End
      Else
      Begin
        strSQL := strSQLConsulta + ' ORDER BY ' + strSQLOrder + strOrderOpc
      End;

      If (Not blnMostraTudo) Or (blnIniciaVazio) Then
        strSQL := strSQL + ' LIMIT 0 ';

    End;

    If not blnPrimeiraVez Then
      strSQL := ReplaceStr(strSQL, 'WHERE FALSE', 'WHERE TRUE');

    blnPrimeiraVez := False;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      qryConsulta.DisableControls;
      If blnRestauraGrid Then
        qryConsulta.EnableControls;
    End;

    pVoltaOrdemGrid;

    pAjustaEdits;
    pAlinhaColunasNumericas;
    pEscondeAutoIncremento(qryConsulta);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmConsultaComp -> pAtuIndice]');
    End;
  End;
  Screen.Cursor := crDefault;
end;

procedure TfrmConsultaComp.edtFiltro1Change(Sender: TObject);
begin
  If (blnFiltraTecla) And (fPodeDigitar(TEdit(Sender).Text)) Then
  Begin

    pAtualizaConsulta;

  End;

end;

Procedure TfrmConsultaComp.pAtualizaConsulta;
  Var
    strSQL: String;
Begin
  If qryConsulta.Active Then
  Begin
    strSQL := fMontaSQL;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      pEscondeAutoIncremento(qryConsulta);
      pAlinhaColunasNumericas;
    End;
  End;
End;

function TfrmConsultaComp.pConsulta(lstIndice, lstDesInd: TStringList): Boolean;
  Var
    intContador: Integer;
    stlAux: TStringList;
begin
  stlAux := TStringList.Create;
  Try
    for intContador := 0 to lstDesInd.Count - 1 do
      stlAux.add(lstDesInd[intContador]);

    lstIndices.Items := stlAux;
    lstIndices.Selected[0] := True;

    lstConInd := lstIndice;
    lstConDes := lstDesInd;
    lstIndices.Items := stlAux;
    blnConfirma := False;
    Self.ShowModal;
    Result := blnConfirma;
  Finally
    stlAux.Free;
  End;
end;

procedure TfrmConsultaComp.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    arrCampos: arrString;
    intContador: Integer;
    blnMarca: Boolean;
begin

  blnMarca := False;
  arrCampos := fProcessaChaveComp(lstConDes.Strings[lstIndices.ItemIndex], '/');

  For intContador := 0 To Length(arrCampos) - 1 Do
  Begin
    If Not Assigned(Column.Field) Then
      Continue;

    If Assigned(Column) And Assigned(Column.Field) And (Column.Field.FieldName = arrCampos[intContador]) then
    Begin
      dbgConsulta.Canvas.Brush.Color:= clInfoBk;
      dbgConsulta.Canvas.Font.Color:= clWindowText;

      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;

  If (blnMarDes) And (qryConsulta.FieldByName('MARDES').AsString = 'M') Then
  Begin
    dbgConsulta.Canvas.Font.Color:= clBlue;
    blnMarca := True;
  End;

  If (strNomTabela = 'COMENG') And (qryConsulta.FieldByName('Baixado').AsString = 'SIM') Then
  Begin
    dbgConsulta.Canvas.Font.Color:= clRed;
    blnMarca := True;
  End;

  If (strNomTabela = 'CADCLI') Then
  Begin
    pnlLegendaCadCli.Visible := True;
    
    If (qryConsulta.FindField('Protestos') <> Nil ) Then
    Begin
      If (Not qryConsulta.FieldByName('Protestos').IsNull) And (qryConsulta.FieldByName('Protestos').AsInteger > 0)  Then
      Begin
        dbgConsulta.Canvas.Font.Color:= clRed;
        blnMarca := True;
      End;
    End;
    If (qryConsulta.FindField('Status') <> Nil ) Then
    Begin
      If (Not qryConsulta.FieldByName('Status').IsNull) And (qryConsulta.FieldByName('Status').AsString = 'I')  Then
      Begin
        dbgConsulta.Canvas.Font.Color:= clPurple;
        blnMarca := True;
      End;
    End;
  End;  

  If (intRecNo = qryConsulta.RecNo) Then
  Begin
    dbgConsulta.Canvas.Font.Color  := clWhite;
    dbgConsulta.Canvas.Brush.Color := clNavy;
    blnMarca := True;
  End;

  If blnMarca Then
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

function TfrmConsultaComp.fRetOperador(strNomeCampo: String): String;
begin
  If qryConsulta.FieldByName(strNomeCampo).DataType In [ftString, ftWideString, ftBlob, ftMemo, ftFmtMemo] Then
    Result := 'LIKE'
  Else If qryConsulta.FieldByName(strNomeCampo).DataType In [ftDate, ftDateTime] Then
    Result := 'DATE'
  Else
    Result := '=';
end;

procedure TfrmConsultaComp.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + strNomTabela + '.* ';

  If Not fEmptyStr(strSQLCamposInners) Then
    strSQL := strSQL + ', ' + strSQLCamposInners + ' ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + strNomTabela;

  If Not fEmptyStr(strSQLInners) Then
    strSQL := strSQL + ' ' + strSQLInners + ' ';

  strSQL := strSQL + ' WHERE ';
  If(qryConsulta.IsEmpty) Then
  Begin
    strSQL := strSQL + ' FALSE ';
  End
  Else
  Begin
    strSQL := strSQL + ' ' + IIF(fEmptyStr(strSQLInners), '', strNomTabela + '.') + strCampoChave + ' = ' + QuotedStr(qryConsulta.FieldByName('AUTOINCREM').AsString);
  End;

  bkmUltAcesso := qryConsulta.GetBookMark;

  With qryTabConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  pSalvaOrdemGrid;  

  blnConfirma := True;
  Close;
end;

procedure TfrmConsultaComp.pEscondeAutoIncremento(qryConsulta: TUniQuery);
begin
  If qryConsulta.FieldDefList.Find('AUTOINCREM') <> Nil Then
    qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  If qryConsulta.FieldDefList.Find('MARDES') <> Nil Then
    qryConsulta.FieldByName('MARDES').Visible := False;
end;

function TfrmConsultaComp.fProcessaChaveComp(strChave, strCaracter: String): arrString;
  Var
    strTemp: String;
    intContador: Integer;
begin
  strTemp  := '';
  strChave := strChave + strCaracter;
  For intContador := 1 To Length(strChave) Do
  Begin
    If (strChave[intContador] <> strCaracter) Then
      strTemp := strTemp + strChave[intContador]
    Else
    Begin
      SetLength(Result, Length(Result)+1);
      Result[length(Result)-1] := Trim(strTemp);
      strTemp := '';
    End;
  End;
end;

Function TfrmConsultaComp.fMontaUltimaPesquisa(strIndice1, strIndice2, strIndice3: String): String;
Begin
  Result := strIndice1 + ' ' + strIndice2 + ' ' + strIndice3;
End;

procedure TfrmConsultaComp.pInicializaUltimaPesquisa;
Begin
  strUltimaPesquisa := fMontaUltimaPesquisa(strUltIndice1,strUltIndice2,strUltIndice3);
End;

procedure TfrmConsultaComp.pSetaUltimaPesquisa;
Begin
  strUltimaPesquisa := fMontaUltimaPesquisa(edtFiltro1.Text,edtFiltro2.Text,edtFiltro3.Text);
End;

procedure TfrmConsultaComp.FormShow(Sender: TObject);
begin
  If Assigned(aftAfterOpen) Then
    qryConsulta.AfterOpen := aftAfterOpen;

  pInicializaUltimaPesquisa;

  If blnMarDes Then
    pMarDesTodosRegistros('D');

  If (Pos('ORDER BY', strOrderOpc) <= 0) And
     (Pos('GROUP BY', strOrderOpc) <= 0) Then
  Begin
    If Not fEmptyStr(strOrderOpc) Then
      strOrderOpc := ', ' + strOrderOpc;
  End;

  inherited;

  If (blnIniciaVazio) Then
  Begin
    edtFiltro1.Clear;
    edtFiltro2.Clear;
    edtFiltro3.Clear;
    blnCheckSaldo := False;
    blnCheckPromo := False;
  End;

  If (Not blnFiltraTecla) Then
  Begin

    If (Not fEmptyStr(edtFiltro1.Text)) Or
       (Not fEmptyStr(edtFiltro2.Text)) Or
       (Not fEmptyStr(edtFiltro3.Text)) Then
    Begin
      pSetFocus(dbgConsulta);
    End;

  End;

  {**********************************************************}
  {* CASO FOR COMPLETE KEY O SISTEMA ABRE A ULTIMA CONSULTA *}
  {* E SETA O INICIAR VAZIO COMO TRUE P/ NÃO CARREGAR A CONS.}
  {* NOVAMENTE, POIS SE O CLIENTE TIVER MTOS DADOS DEMORA   *}
  {*******************************************************GB*}
  if (Not blnFiltraTecla) And (not blnIniciaVazio) Then
    blnIniciaVazio := True;

  chkConsContida.Visible := (Not blnFiltraTecla) And fCfgSis('CONSCO', VarBoolean);

  If (strNomTabela <> 'CADITE') And (strNomTabela <> 'CADCLI') Then
    chkConsContida.Visible := False;

  chkConsContida.Checked := chkConsContida.Visible;

  If chkConsContida.Visible And (strNomTabela = 'CADCLI') Then
  Begin
    stlCamposCompletaComZeros.Add('Código');
    stlCamposCompletaComZeros.Add('Cód. Rede de Lojas');
  End;

  If chkConsContida.Visible And (strNomTabela = 'CADITE') Then
  Begin
    stlCamposCompletaComZeros.Add('Codigo');
    stlCamposCompletaComZeros.Add('Código');
  End;
end;

procedure TfrmConsultaComp.FormCreate(Sender: TObject);
begin
  strCampoChave := 'AUTOINCREM';
  inherited;
  blnFiltraTecla   := True;
  blnMostraTudo    := True;
  blnIniciaVazio   := False;
  intMinimoDigitos := -1;
  blnMarDes        := False;
  blnRestauraGrid  := True;

  qryConsulta.Connection := frmModulo.GetCurrentConnection;
  aftAfterOpen := Nil;

  stlCamposCompletaComZeros := TStringList.Create;
end;

procedure TfrmConsultaComp.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlCamposCompletaComZeros);
end;

procedure TfrmConsultaComp.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtFiltro1);
end;

procedure TfrmConsultaComp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If qryConsulta.Active Then
    strUltSelect := fMontaSQL;
  inherited;
end;

function TfrmConsultaComp.fPodeDigitar(strTexto: String): Boolean;
begin
  Result := False;
  If (intMinimoDigitos = -1) Or (Length(strTexto) >= intMinimoDigitos) Then
    Result := True;
end;

procedure TfrmConsultaComp.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    strSQL: String;
    lblFiltro: TLabel;
begin
  If (blnFiltraTecla) Then
  Begin

    //If blnMarDes Then
    //  pSetFocus(dbgConsulta)
    //Else
      inherited;

  End
  Else If (Key = VK_Return) Then
  Begin

    If (Sender <> Nil) And (Sender Is TEdit) And
       (Not fEmptyStr(TEdit(Sender).Text))   And
       (Pos('edtFiltro', TEdit(Sender).Name) > 0) Then
    Begin
      If FindComponent('lblChave' + RightStr(TEdit(Sender).Name, 1)) <> nil Then
      Begin
        lblFiltro := TLabel(FindComponent('lblChave' + RightStr(TEdit(Sender).Name, 1)));

        If qryConsulta.Active And (qryConsulta.FindField(lblFiltro.Caption) <> nil) Then
        Begin
          If (stlCamposCompletaComZeros.IndexOf(lblFiltro.Caption) > -1) And
             (qryConsulta.FieldByName(lblFiltro.Caption).DataType = ftString) Then
          Begin
            TEdit(Sender).Text := fStrZero(TEdit(Sender).Text, qryConsulta.FieldByName(lblFiltro.Caption).Size);
          End;
        End;
      End;
    End;

    If (Not qryConsulta.IsEmpty) And (Not blnFiltraTecla) And (intMinimoDigitos = 1) And
       (strUltimaPesquisa = fMontaUltimaPesquisa(edtFiltro1.Text,edtFiltro2.Text,edtFiltro3.Text)) Then
    Begin
      btnConfirma.Click;
      Exit;
    End;

    pSetaUltimaPesquisa;

    strSQL := fMontaSQL;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      pEscondeAutoIncremento(qryConsulta);
      pAlinhaColunasNumericas;
    End;

    pSetFocus(dbgConsulta);

  End
  Else If (Key = VK_Escape) Then
  Begin
    btnSair.Click;
  End;

end;

procedure TfrmConsultaComp.edtFiltro1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If chkConsContida.Visible And chkConsContida.Checked Then
  Begin
    If Key = '%' Then
      Key := #0;
  End;

  If qryConsulta.Active And (qryConsulta.FindField(lblChave1.Caption) <> nil) Then
  Begin
    If (qryConsulta.FieldByName(lblChave1.Caption).DataType = ftInteger) And
       (fEmptyStr(fRetSomenteNumeros(Key))) And
       (Key <> #8) Then
      Key := #0;
  End;
end;

procedure TfrmConsultaComp.edtFiltro2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If chkConsContida.Visible And chkConsContida.Checked Then
  Begin
    If Key = '%' Then
      Key := #0;
  End;

  If qryConsulta.Active And (qryConsulta.FindField(lblChave2.Caption) <> nil) Then
  Begin
    If (qryConsulta.FieldByName(lblChave2.Caption).DataType = ftInteger) And
       (fEmptyStr(fRetSomenteNumeros(Key))) And
       (Key <> #8) Then
      Key := #0;
  End;
end;

procedure TfrmConsultaComp.edtFiltro3KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If chkConsContida.Visible And chkConsContida.Checked Then
  Begin
    If Key = '%' Then
      Key := #0;
  End;

  If qryConsulta.Active And (qryConsulta.FindField(lblChave3.Caption) <> nil) Then
  Begin
    If (qryConsulta.FieldByName(lblChave3.Caption).DataType = ftInteger) And
       (fEmptyStr(fRetSomenteNumeros(Key))) And
       (Key <> #8) Then
      Key := #0;
  End;
end;

procedure TfrmConsultaComp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  intRecAtu: Integer;
begin
  If (Key = VK_F5) And (blnMarDes) Then
  Begin
    pMarDesTodosRegistros('M');
    intRecAtu := qryConsulta.RecNo;
    pAtuIndice(lstIndices.ItemIndex);
    qryConsulta.RecNo := intRecAtu;
  End;

  If (Key = VK_F6) And (blnMarDes) Then
  Begin
    pMarDesTodosRegistros('D');
    intRecAtu := qryConsulta.RecNo;
    pAtuIndice(lstIndices.ItemIndex);
    qryConsulta.RecNo := intRecAtu;
  End;

  If (Key = VK_F4) And btnExecutaTarefa.Visible Then
  Begin
    btnExecutaTarefa.Click;
  End Else
  If (Key = VK_Escape) Then
  Begin
    If (blnFiltraTecla) Then
      inherited
    Else
      pSetFocus(edtFiltro1);
  End
  Else
    inherited;

{
  If (Key = VK_F4) And btnExecutaTarefa.Visible Then
    btnExecutaTarefa.Click;

  If (Key = VK_Escape) Then
  Begin
    If (blnFiltraTecla) Then
      inherited
    Else
      pSetFocus(edtFiltro1);
  End;

  If (Key = VK_F3) Then
    inherited;}

  pEscondeAutoIncremento(qryConsulta);
end;

procedure TfrmConsultaComp.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    intRecAtu: Integer;
begin

  If (dbgConsulta.Focused) And (blnMarDes) And (Key = VK_Space) Then
  Begin
    Key := 0;
    qryConsulta.DisableControls;
    pMarDesRegistro;
    intRecAtu := qryConsulta.RecNo;
    pAtuIndice(lstIndices.ItemIndex);
    qryConsulta.RecNo := intRecAtu;
    qryConsulta.EnableControls;
  End;

  inherited;

end;

{**************************************}
{* MARCA / DESMARCA REGISTRO          *}
{***********************************AF*}
procedure TfrmConsultaComp.pMarDesRegistro;
  Var
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE   ');
      SQL.Add(strNomTabela);
      SQL.Add(' SET      ');

      If qryConsulta.FieldByName('MARDES').AsString = 'D' Then
        SQL.Add('  MARDES = "M" ')
      Else
        SQL.Add('  MARDES = "D" ');

      SQL.Add(' WHERE    ');
      SQL.Add('   AUTOINCREM = :AUTINC ');

      ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      ExecSQL;
      Close;
      dbgConsulta.Refresh;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

{**************************************}
{* MARCA / DESMARCA TODOS REGISTROS   *}
{***********************************LU*}
procedure TfrmConsultaComp.pMarDesTodosRegistros(strOpcao: String);
  Var
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE   ');
      SQL.Add(strNomTabela);
      SQL.Add(' SET      ');

      If strOpcao = 'M' Then
        SQL.Add('  MARDES = "M" ')
      Else
        SQL.Add('  MARDES = "D" ');

      If Not fEmptyStr(edtFiltro1.Text) Then
      Begin
        SQL.Add(' WHERE ');
        If chkConsContida.Visible And chkConsContida.Checked Then
          SQL.Add(fGetSQLTextoContido(lstConInd.Strings[lstIndices.ItemIndex], edtFiltro1.Text))
        Else
          SQL.Add(lstConInd.Strings[lstIndices.ItemIndex] + ' LIKE "' + edtFiltro1.Text + '%"');
      End;        

      ExecSQL;
      Close;
      dbgConsulta.Refresh;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmConsultaComp.dbgConsultaDblClick(Sender: TObject);
  Var
    intRecAtu: Integer;
begin

  If (blnMarDes) Then
  Begin
    intRecAtu := qryConsulta.RecNo;
    pMarDesRegistro;
    pAtuIndice(lstIndices.ItemIndex);
    qryConsulta.RecNo := intRecAtu;
  End

  Else
    inherited;

end;

procedure TfrmConsultaComp.pSalvaOrdemGrid;
begin

  Try
    If strNomTabela = 'CADPAG' Then
    Begin
      If (Pos(Copy(strNomeForm,1,Length(strNomeForm)-1),'frmCadCtaPagarCADPAG') > 0) Then
        dbgConsulta.Columns.SaveToFile(ExtractFilePath(Application.ExeName) + 'frmCadCtaPagarCADPAG');
    End
    Else If strNomTabela = 'CADREC' Then
    Begin
      If (Pos(strNomeForm, 'frmCadCtaReceberCADREC') > 0)  Then
        dbgConsulta.Columns.SaveToFile(ExtractFilePath(Application.ExeName) + 'frmCadCtaReceberCADREC');
    End;

  Except

  End;

end;

function TfrmConsultaComp.fGetSQLTextoContido(strCampo, strTexto: String): String;
  Var
    stlTexto: TStringList;
begin
  Result := '';

  Repeat
    strTexto := AnsiReplaceStr(strTexto, '  ', ' ');
  Until (Pos('  ', strTexto) <= 0);

  If fEmptyStr(strTexto) Then
    Exit;

  stlTexto := TStringList.Create;
  ExtractStrings([' '], [], PChar(strTexto), stlTexto);

  For strTexto In stlTexto Do
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + ' AND ';
    Result := Result + strCampo  + ' LIKE ' + QuotedStr('%' + strTexto + '%');
  End;

  FreeAndNil(stlTexto);
end;

procedure TfrmConsultaComp.pVoltaOrdemGrid;
begin

  Try
    If strNomTabela = 'CADPAG' Then
    Begin
      If (Pos(Copy(strNomeForm,1,Length(strNomeForm)-1),'frmCadCtaPagarCADPAG') > 0) Then
      Begin
        If FileExists(ExtractFilePath(Application.ExeName) + 'frmCadCtaPagarCADPAG') Then
          dbgConsulta.Columns.LoadFromFile(ExtractFilePath(Application.ExeName) + 'frmCadCtaPagarCADPAG');
      End;
    End
    Else If  strNomTabela = 'CADREC' Then
    Begin
      If (Pos(strNomeForm,'frmCadCtaReceberCADREC') > 0) Then
      Begin
        If FileExists(ExtractFilePath(Application.ExeName) + 'frmCadCtaReceberCADREC') Then
          dbgConsulta.Columns.LoadFromFile(ExtractFilePath(Application.ExeName) + 'frmCadCtaReceberCADREC');
      End;
    End;
    
  Except

  End;

end;

end.




