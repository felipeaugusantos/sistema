unit untPesquisa;

interface

Uses
  ExtCtrls,
  EditFocus,
  Dialogs,
  Uni, SysUtils,
  DB, UniClientDataSet, UniDataSetProvider,
  Controls,
  Classes,
  StrUtils,
  cxVGrid,
  cxEdit,
  cxClasses,
  cxCustomData,
  cxCalendar,
  cxTimeEdit,
  cxCurrencyEdit,
  Variants,
  Contnrs,
  untClassPanelCx;

Type
  TRecFiltro = Record
    strNomCam: String;
    varValor: Variant;
  End;

  TArrFiltro = Array Of TRecFiltro;

  {$M+}
  TDefFiltro = Class(TObject)
    Private

      FRecNo,
      FIndRow : Integer;
      FChave  : String;
      FFiltros: TArrFiltro;

      Function fNomeRowToNomeCampo(strNomCam: String): String;

    Public

      Procedure pCarregaFiltros(cxgPesquisa: TcxVerticalGrid);
      Procedure pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);

    published

      property strChave:  String  Read FChave  Write FChave;
      property intRecNo:  Integer Read FRecNo  Write FRecNo;
      property intIndRow: Integer Read FIndRow Write FIndRow;
  End;

  TPesquisa = Class(TObject)
    Private

      FRecNo,
      FIndRow : Integer;

      FPosFil: Integer;
      FLisFil: TObjectList;

      Function fNomeRowToNomeCampo(strNomCam: String): String;

    Public

      constructor Create; Reintroduce;

      Destructor Destroy; override;

      Procedure pLimparFiltros(cxgPesquisa: TcxVerticalGrid);
      Procedure pCarregaFiltros(arrFiltros: TarrFiltros; strChave: String; cxgPesquisa: TcxVerticalGrid; blnTestaFiltro: Boolean);
      Procedure pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);
      Function fCarregaFiltrosParametros(arrFiltros: TarrFiltros; cxgPesquisa: TcxVerticalGrid): Boolean;

    published

      property intRecNo:  Integer Read FRecNo  Write FRecNo;
      property intIndRow: Integer Read FIndRow Write FIndRow;
  End;
  {$M-}
Var
  objPesquisa: TPesquisa;

implementation

uses
  untFuncoesGen;

constructor TPesquisa.Create;
Begin
  Inherited Create;

  FLisFil := TObjectList.Create;
  FPosFil := -1;
End;

Destructor TPesquisa.Destroy;
Begin
  Inherited;

  FreeAndNil(FLisFil);
End;

procedure TPesquisa.pLimparFiltros(cxgPesquisa: TcxVerticalGrid);
  Var
    intContador: Integer;
begin
  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
    TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value := Null;
end;

Procedure TPesquisa.pCarregaFiltros(arrFiltros: TarrFiltros; strChave: String; cxgPesquisa: TcxVerticalGrid; blnTestaFiltro: Boolean);
  Var
    intContador: Integer;
    objFiltro: TDefFiltro;
    blnAchou: Boolean;
Begin
  blnAchou := False;

  FIndRow := 1;
  FRecNo  := 1;

  For intContador := 0 To FLisFil.Count - 1 Do
  Begin
    objFiltro := TDefFiltro(FLisFil.Items[intContador]);

    If objFiltro.strChave = strChave then
    Begin
      FPosFil := intContador;

      If (Not blnTestaFiltro) Or
         ((Not Assigned(arrFiltros)) Or (Length(arrFiltros) = 0)) Then
        objFiltro.pCarregaFiltros(cxgPesquisa);

      FIndRow :=  objFiltro.intIndRow;
      FRecNo  :=  objFiltro.intRecNo;

      blnAchou := True;
      Break;
    End;

  End;

  If Not blnAchou Then
  Begin
    objFiltro          := TDefFiltro.Create;
    objFiltro.strChave := strChave;
    FPosFil            := FLisFil.Add(objFiltro);
  End;

End;

Function TPesquisa.fNomeRowToNomeCampo(strNomCam: String): String;
Begin
  If EndsText('_1', strNomCam) Or EndsText('_1', strNomCam) Then
    Result := LeftStr(strNomCam, Length(strNomCam) - 2)
  Else
    Result := strNomCam;
End;

Function TPesquisa.fCarregaFiltrosParametros(arrFiltros: TarrFiltros; cxgPesquisa: TcxVerticalGrid): Boolean;
  Var
    intContador,
    intFiltro: Integer;
Begin
  Result := False;

  If (Not Assigned(arrFiltros)) Or (Length(arrFiltros) = 0) Then
    Exit;

  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
  Begin
    if Not cxgPesquisa.Rows[intContador].Visible then
      Break;

    For intFiltro := Low(arrFiltros) To High(arrFiltros) Do
    Begin
      If (arrFiltros[intFiltro].strNomCam =  fNomeRowToNomeCampo(cxgPesquisa.Rows[intContador].Name)) Then
      Begin
        Result := True;
        TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value := arrFiltros[intFiltro].strInfCam;
      End;
    End;

  End;
End;

Procedure TPesquisa.pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);
  Var
    objFiltro: TDefFiltro;
Begin
  if FPosFil > -1 then
  Begin
    objFiltro := TDefFiltro(FLisFil.Items[FPosFil]);
    objFiltro.pSalvaFiltros(cxgPesquisa, intRecNo);
  End;
End;

Function TDefFiltro.fNomeRowToNomeCampo(strNomCam: String): String;
Begin
  If EndsText('_1', strNomCam) Or EndsText('_1', strNomCam) Then
    Result := LeftStr(strNomCam, Length(strNomCam) - 2)
  Else
    Result := strNomCam;
End;

Procedure TDefFiltro.pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);
  Var
    intContador: Integer;
Begin
  FRecNo  := intRecNo;

  If Assigned(cxgPesquisa.FocusedRow) Then
    FIndRow := cxgPesquisa.FocusedRow.Index
  Else
    FIndRow := 1;

  SetLength(FFiltros, Pred(cxgPesquisa.Rows.Count));

  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
  Begin
    FFiltros[Pred(intContador)].strNomCam := fNomeRowToNomeCampo(cxgPesquisa.Rows[intContador].Name);
    FFiltros[Pred(intContador)].varValor  := TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value;
  End;

End;

Procedure TDefFiltro.pCarregaFiltros(cxgPesquisa: TcxVerticalGrid);
  Var
    intContador,
    intFiltro: Integer;
Begin

  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
  Begin
    if Not cxgPesquisa.Rows[intContador].Visible then
      Break;

    For intFiltro := Low(FFiltros) To High(FFiltros) Do
    Begin
      If (FFiltros[intFiltro].strNomCam = fNomeRowToNomeCampo(cxgPesquisa.Rows[intContador].Name)) Then
        TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value := FFiltros[intFiltro].varValor;
    End;

  End;

  If cxgPesquisa.Rows.Count > FIndRow Then
    cxgPesquisa.FocusRow(cxgPesquisa.Rows[FIndRow]);
End;

Initialization
  objPesquisa := TPesquisa.Create;
Finalization
  FreeAndNil(objPesquisa);
end.

