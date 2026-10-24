unit untLogAltCadIte;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider;

Type
  TLogAltCadIte = Class(TComponent)
  Private


  Public

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor  Destroy; Override;

    Class Procedure pGravaLogAlteracao(qryCadIte: TUniQuery; strTipAbf:String = '1'; strTpaBpc:String = '1');
    class procedure pGravaLogAlteracaoIndividual(strCodIte: String; Field: String; OldValue: Variant; NewValue: Variant);
  End;

implementation

Uses
  untFuncoesSimples;

constructor TLogAltCadIte.Create(Owner: TComponent);
begin
  Inherited Create(Owner);

End;

destructor TLogAltCadIte.Destroy;
begin

  inherited Destroy;
end;

Class Procedure TLogAltCadIte.pGravaLogAlteracao(qryCadIte: TUniQuery; strTipAbf:String = '1'; strTpaBpc:String = '1');
  Var
    qryLogCpr: TUniQuery;
    intContador: Integer;
    blnRealizaInsertDoLog: Boolean;
    strAutInc,
    strAutIncBkp: String;

  Function fUpper(strInfo: String): String;
    Const
      ComAcento = 'àâêôûãõáéíóúçü´';
    Var
      intContador: Integer;
  Begin
    Result := UpperCase(strInfo);

    For intContador := 1 To Length(strInfo) Do
      Case Result[intContador] Of
        'à': Result[intContador] := 'À';
        'â': Result[intContador] := 'Â';
        'ê': Result[intContador] := 'Ê';
        'ô': Result[intContador] := 'Ô';
        'û': Result[intContador] := 'Û';
        'ã': Result[intContador] := 'Ã';
        'õ': Result[intContador] := 'Õ';
        'á': Result[intContador] := 'Á';
        'é': Result[intContador] := 'É';
        'í': Result[intContador] := 'Í';
        'ó': Result[intContador] := 'Ó';
        'ú': Result[intContador] := 'Ú';
        'ç': Result[intContador] := 'Ç';
        'ü': Result[intContador] := 'Ü';
      End;
  End;

Begin

  If (strTipAbf = '2') Or (strTpaBpc = '2') Then
    pSetaDisplayLabelIteGer(qryCadIte)
  Else
    pSetaDisplayLabelCadIte(qryCadIte);

  qryLogCpr := fCriaQuery;
  Try
    qryLogCpr.SQL.Text := 'SELECT * FROM LOGCPR WHERE FALSE';
    qryLogCpr.Open;


    strAutInc:=  fRetAutoIncrem('LOGCPR', VS_strCodEmp, qryCadIte.Fields.Count + 1);
    strAutIncBkp := strAutInc;

    With qryLogCpr Do
    For intContador := 0 To qryCadIte.Fields.Count - 1 Do
      If (Pos(qryCadIte.Fields[intContador].FieldName, 'ITE_HULALT-') <= 0) And
         (Not (qryCadIte.Fields[intContador].IsNull And (qryCadIte.Fields[intContador].OldValue = Null))) And
         (((qryCadIte.Fields[intContador].DataType = ftString) And
           (qryCadIte.Fields[intContador].AsString <> qryCadIte.Fields[intContador].OldValue)) Or
           (qryCadIte.Fields[intContador].OldValue <> qryCadIte.Fields[intContador].Value)) Then
      Begin
        blnRealizaInsertDoLog:= True;
        If (strTipAbf = '2') Or (strTpaBpc = '2') Then
          blnRealizaInsertDoLog:= (qryCadIte.Fields[intContador].FieldName = 'ITE_CODABF') Or
                                  (qryCadIte.Fields[intContador].FieldName = 'ITE_ABFPIS') Or
                                  (qryCadIte.Fields[intContador].FieldName = 'ITE_ABFCOF') Or
                                  (qryCadIte.Fields[intContador].FieldName = 'ITE_ABFIPI');

        If (blnRealizaInsertDoLog) Then
        Begin
          Insert;
          FieldByName('AUTOINCREM').AsString := strAutInc;
          FieldByName('LOG_CODITE').AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
          FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
          FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
          FieldByName('LOG_HORALT').AsDateTime := fTime();
          FieldByName('LOG_NOMCAM').AsString := fUpper(qryCadIte.Fields[intContador].DisplayLabel);
          FieldByName('LOG_EMPLOG').AsString := VS_strCodEmp;
          FieldByName('LOG_EMPFIS').AsString := fRetEmpresaFisica;

          Case qryCadIte.Fields[intContador].DataType of
            ftFloat :  Begin
                        If qryCadIte.Fields[intContador].OldValue <> Null Then
                          FieldByName('LOG_VALANT').AsString := FormatFloat('#,##0.00', qryCadIte.Fields[intContador].OldValue);

                        If Not qryCadIte.Fields[intContador].IsNull Then
                          FieldByName('LOG_VALPOS').AsString := FormatFloat('#,##0.00', qryCadIte.Fields[intContador].AsFloat);
                      End;

            ftTime :  Begin
                        If qryCadIte.Fields[intContador].OldValue <> Null Then
                          FieldByName('LOG_VALANT').AsString := FormatDateTime('HH:NN', qryCadIte.Fields[intContador].OldValue);

                        If Not qryCadIte.Fields[intContador].IsNull Then
                          FieldByName('LOG_VALPOS').AsString := FormatDateTime('HH:NN', qryCadIte.Fields[intContador].AsDateTime);
                      End;

            ftDate :  Begin
                        If qryCadIte.Fields[intContador].OldValue <> Null Then
                          FieldByName('LOG_VALANT').AsString := FormatDateTime('DD/MM/YYYY', qryCadIte.Fields[intContador].OldValue);

                        If Not qryCadIte.Fields[intContador].IsNull Then
                          FieldByName('LOG_VALPOS').AsString := FormatDateTime('DD/MM/YYYY', qryCadIte.Fields[intContador].AsDateTime);
                      End;

            ftDateTime :Begin
                          If qryCadIte.Fields[intContador].OldValue <> Null Then
                            FieldByName('LOG_VALANT').AsString := FormatDateTime('DD/MM/YYYY HH:NN', qryCadIte.Fields[intContador].OldValue);

                          If Not qryCadIte.Fields[intContador].IsNull Then
                            FieldByName('LOG_VALPOS').AsString := FormatDateTime('DD/MM/YYYY HH:NN', qryCadIte.Fields[intContador].AsDateTime);
                        End;

            ftWord,
            ftInteger,
            ftSmallint,
            ftMemo,
            ftString: Begin
                        If qryCadIte.Fields[intContador].OldValue <> Null Then
                          FieldByName('LOG_VALANT').AsString := qryCadIte.Fields[intContador].OldValue;

                        If Not qryCadIte.Fields[intContador].IsNull Then
                          FieldByName('LOG_VALPOS').AsString := qryCadIte.Fields[intContador].AsString;
                      End;
            Else
              Begin
                If qryCadIte.Fields[intContador].OldValue <> Null Then
                  FieldByName('LOG_VALANT').Value := qryCadIte.Fields[intContador].OldValue;

                If Not qryCadIte.Fields[intContador].IsNull Then
                  FieldByName('LOG_VALPOS').Value := qryCadIte.Fields[intContador].Value;
              End;
          End;

          Post;

          pIncrementaAutoIncrem(strAutIncBkp);
          strAutInc := strAutIncBkp;
        End;
      End;

  Finally
    FreeAndNil(qryLogCpr);
  End;
End;


class procedure TLogAltCadIte.pGravaLogAlteracaoIndividual(strCodIte: String; Field: String; OldValue, NewValue: Variant);
  Var
    qryLogCpr: TUniQuery;
begin
  qryLogCpr := fCriaQuery;
  qryLogCpr.SQL.Text := 'SELECT * FROM LOGCPR WHERE FALSE';
  qryLogCpr.Open;

  qryLogCpr.Insert;

  qryLogCpr.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCPR', VS_strCodEmp);
  qryLogCpr.FieldByName('LOG_CODITE').AsString := strCodite;
  qryLogCpr.FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
  qryLogCpr.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
  qryLogCpr.FieldByName('LOG_HORALT').AsDateTime := fTime();
  qryLogCpr.FieldByName('LOG_NOMCAM').AsString := Uppercase(Field);
  qryLogCpr.FieldByName('LOG_EMPLOG').AsString := VS_strCodEmp;
  qryLogCpr.FieldByName('LOG_EMPFIS').AsString := fRetEmpresaFisica;
  qryLogCpr.FieldByName('LOG_VALANT').Value := OldValue;
  qryLogCpr.FieldByName('LOG_VALPOS').Value := NewValue;

  qryLogCpr.Post;

end;


end.
