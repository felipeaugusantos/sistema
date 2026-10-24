{*******************************************}
{* CLASSE PARA MANUTENÇÃO DE KM RODADO     *}
{* DATA......: 09/08/2010                  *}
{****************************************PZ*}
unit untManKmt;

interface

uses StrUtils, SysUtils, Classes, Forms, DB, untFuncoesSimples, Uni;

Type TManKmt = Class (TComponent)
  Private
    FDtaCad: String;
    FPlaVei: String;
    FCodEmp: String;
    FKmtIni: String;
    FKmtFin: String;
    FAutInc: String;
    FAbaVlr: Double;
    FAbaLit: Double;
    FTipLan: String;
    FHistor: String;
    FManVlr: Double;

    procedure pAfterOpen(Dataset: TDataSet);

  Public

    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strDtaCad: String Read FDtaCad Write FDtaCad;
    Property strPlaVei: String Read FPlaVei Write FPlaVei;
    Property strCodEmp: String Read FCodEmp Write FCodEmp;
    Property strKmtIni: String Read FKmtIni Write FKmtIni;
    Property strKmtFin: String Read FKmtFin Write FKmtFin;
    Property strAutInc: String Read FAutInc Write FAutInc;
    Property fltAbaVlr: Double Read FAbaVlr Write FAbaVlr;
    Property fltAbaLit: Double Read FAbaLit Write FAbaLit;
    Property fltManVlr: Double Read FManVlr Write FManVlr;
    Property strHistor: String Read FHistor Write FHistor;
    Property strTipLan: String Read FTipLan Write FTipLan;

    Constructor Create(Owner: TComponent); Reintroduce;

    Function fRetornaKmFinal(strPlaVei: String; strFiltro: String = ''; strTipLan : String = ''): String;
    Function fUltimoLanc(strPlaVei: String): String;
    Function fCalculaConsumoLitros(intKmtIni, intKmtFin: Integer; fltLitAba: Double): String;
    Function fCalculaConsumoValor(intKmtIni, intKmtFin: Integer; fltVlrAba: Double): String;
    Function fCalculaKmPorLitro(intKmtIni, intKmtFin: Integer; fltVlrAba: Double): String;
    Function fCalculaValorDoLitro(fltVlrAba: Double; fltTotLitros: Double): String;

  end;

Const
  arrCampos   : Array[0..7] Of String = ( 'KMT_DTACAD','KMT_CODEMP','KMT_PLAVEI','KMT_KMTINI','KMT_KMTFIN',
                                          'KMT_ABAVLR','KMT_ABALIT','AUTOINCREM');

  arrDescricao: Array[0..7] Of String = ( 'Data','Empresa','Placa','Km.Inicial','Km.Final',
                                          'Abast.Valor','Abast.Litros','AUTOINCREM');

  arrTipo     : Array[0..7] Of TFieldType = ( ftDate, ftString, ftString, ftString, ftString,
                                              ftFloat, ftFloat, ftString);
  arrTamanhos : Array[0..7] Of Integer    = ( 10, 3, 7, 7, 7, 15, 15, 20 );
  arrVisible  : Array[0..7] Of Boolean    = ( True, True, True, True, True, True, True, False );
  arrFormat   : Array[0..7] Of String     = ( 'DD/MM/YYYY', '', '', '', '', '#,##0.00', '#,##0.000', '' );

implementation

{ TCadVei }

constructor TManKmt.Create(Owner: TComponent);
  Var
    IntContador: Integer;
begin

  Try
    SetLength(arrDefCam, 7);

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam  := arrCampos[intContador];
      arrDefCam[intContador].strDesCri  := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam  := arrTipo[intContador];
      arrDefCam[intContador].intTamCam  := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible := arrVisible[intContador];
      arrDefCam[intContador].strFormat  := arrFormat[intContador];
    End;

    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM MANKMT WHERE FALSE');
    qryTabela.Open;

    FDtaCad := '';
    FPlaVei := '';
    FCodEmp := '';
    FKmtIni := '';
    FKmtFin := '';
    FAutInc := '';
    FAbaVlr := 0;
    FAbaLit := 0;
    FTipLan := 'A';
    FHistor := '';
    FManVlr := 0;

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto ManKmt!' + #13 + E.Message);

  End;

End;

function TManKmt.fCalculaConsumoLitros(intKmtIni, intKmtFin: Integer;
  fltLitAba: Double): String;
begin
  If ((intKmtFin - intKmtIni) <> 0) Then
    Result := FormatFloat('#,##0.000', fltLitAba / (intKmtFin - intKmtIni))
  Else
    Result := FormatFloat('#,##0.000', 0);
end;

function TManKmt.fCalculaConsumoValor(intKmtIni, intKmtFin: Integer;
  fltVlrAba: Double): String;
begin
  If ((intKmtFin - intKmtIni) <> 0) Then
    Result := FormatFloat('#,##0.00', fltVlrAba / (intKmtFin - intKmtIni))
  Else
    Result := FormatFloat('#,##0.00', 0);
end;

function TManKmt.fCalculaKmPorLitro(intKmtIni, intKmtFin: Integer;
  fltVlrAba: Double): String;
begin
  If (fltVlrAba <> 0) Then
    Result := FormatFloat('#,##0.0000', (intKmtFin - intKmtIni) / fltVlrAba)
  Else
    Result := FormatFloat('#,##0.0000', 0);
end;

function TManKmt.fCalculaValorDoLitro(fltVlrAba: Double; fltTotLitros: Double): String;
begin
  If (fltVlrAba <> 0) And (fltTotLitros <> 0) Then
    Result := FormatFloat('#,##0.000', (fltVlrAba / fltTotLitros) )
  Else
    Result := FormatFloat('#,##0.000', 0);
end;

function TManKmt.fRetornaKmFinal(strPlaVei: String; strFiltro: String = ''; strTipLan : String = ''): String;
Var
  strSQL: String;
  qryKmt: TUniQuery;
begin

  Try

    qryKmt := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  IFNULL(MAX(CONVERT(KMT_KMTFIN, UNSIGNED)),0) AS KMTFIN ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MANKMT ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  KMT_PLAVEI = :PLAVEI  ';

    If (Not fEmptyStr(strFiltro)) Then
      strSQL := strSQL + '  AND AUTOINCREM <> :AUTINC ';

    if (Not fEmptyStr(strTipLan)) Then
      strSQL := strSQL + 'AND KMT_TIPLAN = :TIPLAN ';

    With qryKmt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('PLAVEI').AsString := strPlaVei;

      If (Not fEmptyStr(strFiltro)) Then
        ParamByName('AUTINC').AsString := strFiltro;

      if (Not fEmptyStr(strTipLan)) Then
        ParamByName('TIPLAN').AsString := strTipLan;

      Open;

      Result := FieldByName('KMTFIN').AsString;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TManKmt.fRetornaKmFinal]');
  End;

  FreeAndNil(qryKmt);

end;

function TManKmt.fUltimoLanc(strPlaVei: String): String;
Var
  strSQL: String;
  qryUlt: TUniQuery;
begin

  Try

    qryUlt := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  MAX(LPAD(KMT_KMTFIN, 7, "0")) AS KMTFIN ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MANKMT ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  KMT_PLAVEI = :PLAVEI ';

    With qryUlt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('PLAVEI').AsString := strPlaVei;
      Open;
      Result := FieldByName('KMTFIN').AsString;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TManKmt.fUltimoLanc]');
  End;

  FreeAndNil(qryUlt);

end;

procedure TManKmt.pAfterOpen(Dataset: TDataSet);
begin
  TStringField(qryTabela.FieldByName('KMT_DTACAD')).EditMask     := 'DD/MM/YYYY';

  TFloatField(qryTabela.FieldByName('KMT_ABAVLR')).EditFormat    := '#,##0.00';
  TFloatField(qryTabela.FieldByName('KMT_ABALIT')).EditFormat    := '#,##0.000';
  TFloatField(qryTabela.FieldByName('KMT_MANVLR')).EditFormat    := '#,##0.00';
  TFloatField(qryTabela.FieldByName('KMT_ABAVLR')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('KMT_ABALIT')).DisplayFormat := '#,##0.000';
  TFloatField(qryTabela.FieldByName('KMT_MANVLR')).DisplayFormat := '#,##0.00';
end;

end.
