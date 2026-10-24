unit untConsultaCompTintaNova;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, untConsultaCompTinta, DB, StdCtrls, Grids, DBGridCitel, DBGrids,
  untIConsulta,  BitBtnLockedIncrem,   Uni, ExtCtrls, ComCtrls, Buttons,
  untFuncoesSimples, Variants, Math, StrUtils, Clipbrd, MemDS, DBAccess, untPnlBotoesAcoesNovaConsulta;

type
  TfrmConsultaCompTintaNova = class(TfrmConsultaCompTinta)
    procedure qryConsultaAfterOpen(DataSet: TDataSet);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
    procedure qryConsultaAfterClose(DataSet: TDataSet);
    procedure dbgConsultaDrawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
    procedure qryConsultaBeforeScroll(DataSet: TDataSet);
  private
    { Private declarations }
    tinta: IConsulta;
    dicTamanhos: TDicionario;
  protected
    strIdePro: string;
    function fMontaSQL: String; override;
    procedure pAjustaTamanho;
  public
    constructor Create(AOwner: TComponent; tipoConsulta: TTipoConsulta; strTabPre: String;
                tinta: IConsulta; const strIdePro: string); reintroduce; virtual;
    destructor Destroy; override;
    { Public declarations }
  end;

  TfrmConsultaCompTintaNovaClass = class of TfrmConsultaCompTintaNova;


var
  frmConsultaCompTintaNova: TfrmConsultaCompTintaNova;

implementation
uses untConsulta;
{$R *.dfm}

{ TfrmConsultaCompTinta1 }

constructor TfrmConsultaCompTintaNova.Create(AOwner: TComponent;
  tipoConsulta: TTipoConsulta; strTabPre: String; tinta: IConsulta; const strIdePro: string);
begin
  Inherited Create(AOwner, tipoConsulta, strTabPre);
  Self.tinta := tinta;
  Self.strIdePro := strIdePro;
  Self.dicTamanhos := TDicionario.Create;
  Self.strTabPre := strTabPre;

  blnConPre := AOwner.Name = 'frmPrincipal';
end;

procedure TfrmConsultaCompTintaNova.qryConsultaAfterClose(DataSet: TDataSet);
begin
  inherited;

 if Assigned(dicTamanhos) then
    dicTamanhos.Limpar;
end;

procedure TfrmConsultaCompTintaNova.qryConsultaAfterOpen(DataSet: TDataSet);
var
  intCont: Integer;
begin
  For intCont := 0 To qryConsulta.FieldCount - 1 Do
  Begin
    qryConsulta.Fields[intCont].DisplayLabel := tinta.fGetCaptionColuna(qryConsulta.Fields[intCont].FieldName);
  End;
  
  dicTamanhos.Limpar;
  DataSet.Next;
  DataSet.First;
end;

procedure TfrmConsultaCompTintaNova.qryConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pAjustaTamanho;
end;

procedure TfrmConsultaCompTintaNova.qryConsultaBeforeScroll(DataSet: TDataSet);
begin
  inherited;
  dicTamanhos.Limpar;
end;

procedure TfrmConsultaCompTintaNova.dbgConsultaDrawColumnCell(Sender: TObject;
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

    If Assigned(Column) And Assigned(Column.Field)
      And (tinta.fGetCaptionColuna(Column.Field.FieldName) = arrCampos[intContador]) then
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

  If (intRecNo = qryConsulta.RecNo) Then
  Begin
    dbgConsulta.Canvas.Font.Color  := clWhite;
    dbgConsulta.Canvas.Brush.Color := clNavy;
    blnMarca := True;
  End;

  If blnMarca Then
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmConsultaCompTintaNova.dbgConsultaDrawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
var
  intLargura: Integer;
  varLarguraAtual: Variant;
  strChave: string;

  strTextoTitulo: string;
  intTamanhoTextoTitulo: Integer;
  strTextoCelula: string;
  intTamanhoTextoCelula: Integer;
begin
  if not Assigned(Field) then
    Exit;

  strChave := Field.FieldName;
  if fEmptyStr(strChave) then
    Exit;

  strTextoTitulo := Field.DisplayLabel + '  ';
  strTextoCelula := VarToStrDef(Field.Value, '') + '  ';
  intTamanhoTextoTitulo := dbgConsulta.Canvas.TextWidth(strTextoTitulo);
  intTamanhoTextoCelula := dbgConsulta.Canvas.TextWidth(strTextoCelula);

  varLarguraAtual := dicTamanhos[strChave];
  intLargura := Max(intTamanhoTextoTitulo, intTamanhoTextoCelula);

  if (intLargura > 0) then
  begin
    if (varLarguraAtual = Null) or (intLargura > varLarguraAtual) then
    begin
      dicTamanhos[strChave] := intLargura;
    end;
  end;
end;

destructor TfrmConsultaCompTintaNova.Destroy;
begin
  if Assigned(dicTamanhos) then FreeAndNil(dicTamanhos);
  inherited;
end;

function TfrmConsultaCompTintaNova.fMontaSQL: String;
  Var
    strSQL      : String;
    strSQLOrder : String;
    strOperador : String;
    strCampo    : String;
    strNomeCampo: String;
    strDesCampo : String;
    strGroup    : String;
    intQtdCampos: Integer;
    intIndCampo : Integer;
    intPosGroup : Integer;
    blnFiltroBranco: Boolean;
    intQtdCamposPesquisa: Integer;
    edtPesquisa: TEdit;

  function fGetNomeCampo(strNomeCampoOri: String): String;
  begin
    If Pos('.', strNomeCampoOri) <= 0 Then
      Result := strNomeCampoOri
    Else
      Result := Copy(strNomeCampoOri, Pos('.', strNomeCampoOri) + 1, Length(strNomeCampoOri));
  end;
begin

  blnFiltroBranco := True;
  //strGroup := '';

  intQtdCampos := fContaCampos(lstConInd.Strings[lstIndices.ItemIndex]);
  intIndCampo  := lstIndices.ItemIndex;

  strSQL       := strSQLConsultaOri;
  strSQLOrder  := fRetOrderBy(lstConInd.Strings[lstIndices.ItemIndex]);
  strDesCampo  := lstConDes.Strings[lstIndices.ItemIndex];
  strNomeCampo := lstConInd.Strings[intIndCampo] + '+';

  For intQtdCamposPesquisa := 1 To intQtdCampos Do
  Begin

    strCampo := Copy(strNomeCampo, 1, Pos('+', strNomeCampo) - 1);
    edtPesquisa := TEdit(FindComponent('edtFiltro' + IntToStr(intQtdCamposPesquisa)));

    If (Not fEmptyStr(edtPesquisa.Text)) Then
    Begin
      intPosGroup  := Pos('GROUP BY', strSQL);
      if intPosGroup > 0 then
      begin
        strGroup := Copy(strSQL,intPosGroup - 1,Length(strSQL));
        strSQL   := Copy(strSQL,1,intPosGroup - 1);
      end;

      strSQL      := strSQL + ' AND ';
      strOperador := tinta.fGetOperador(strCampo);
      If strOperador = 'LIKE' Then
        strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtPesquisa.Text + '%')
      Else If strOperador = 'DATE' Then
        strSQL := strSQL + fAsDAte(fGetNomeCampo(strCampo), edtPesquisa.Text)
      Else
        strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtPesquisa.Text;

      blnFiltroBranco := False;
    End;

    strNomeCampo := Copy(strNomeCampo, Pos('+', strNomeCampo) + 1, Length(strNomeCampo));

    strSQL := strSQL + strGroup;
    strGroup := '';
  End;

  strSQLConsulta := strSQL;

  If (Pos('ORDER BY', strOrderOpc) > 0) Then
  Begin
    strSQL := strSQL + ' ' + strOrderOpc;
    strSQLOrder := '';
  End
  Else If (Pos('GROUP BY', strOrderOpc) > 0) Then
  Begin
    strSQL := strSQL + ' ' + strOrderOpc +  ' ORDER BY ' + strSQLOrder;
  End
  Else
  Begin
    strSQL := strSQL + ' ORDER BY ' + strSQLOrder + strOrderOpc;
  End;

  If (Not blnMostraTudo) And (blnFiltroBranco) Then
    strSQL := strSQL + ' LIMIT 0 ';

  Result := strSQL;
end;

procedure TfrmConsultaCompTintaNova.FormShow(Sender: TObject);
begin
  Self.strUltSelect := Self.strSQLConsulta;
  inherited;
end;

procedure TfrmConsultaCompTintaNova.pAjustaTamanho;
var
  intCont: Integer;
begin
  for intCont := 0 to dbgConsulta.Columns.Count - 1 do
  begin
    if dicTamanhos[dbgConsulta.Columns.Items[intCont].FieldName] <> Null then
    begin
      dbgConsulta.Columns.Items[intCont].Width := dicTamanhos[dbgConsulta.Columns.Items[intCont].FieldName];
    end;
  end;
end;

end.
