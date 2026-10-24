unit untModeloFast;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  frxClass, frxDBSet, frxDesgn, frxDMPExport, Uni, DB,
  untFuncoesSimples;

type
  TModeloFast = class(TComponent)
    private
      FFrxReport: TfrxReport;
      FFrxDesign: TfrxDesigner;
      FFrxDotMatrix: TfrxDotMatrixExport;

      FTabela: TUniQuery;
      FEditou: Boolean;

    public

      function fLoadReport(blnMatricial: Boolean): Boolean;
      function fSaveReport: Boolean;

      Function fSalvaBackup(qryModelo: TUniQuery): Boolean;
      Function fRestauraBackup(qryCadMod: TUniQuery; strCodBkp: String): Boolean;

      procedure pEditLayout;
      procedure pClear;

      constructor Create(AOwner: TComponent; qryTabela: TUniQuery);  Reintroduce;
      destructor Destroy; override;

    published

      Property blnEditou: Boolean Read FEditou Write FEditou;
  end;


implementation

constructor TModeloFast.Create(AOwner: TComponent; qryTabela: TUniQuery);
begin
  inherited Create(AOwner);
  FFrxReport    := TfrxReport.Create(Self);
  FFrxDesign    := TfrxDesigner.Create(Self);
  FFrxDotMatrix := TfrxDotMatrixExport.Create(Self);
  FFrxDotMatrix.PageBreaks := True;
  FFrxDesign.Restrictions := [drDontSaveReport, drDontLoadReport, drDontCreateReport];

  FTabela := qryTabela;

  FEditou := False;
end;

destructor TModeloFast.Destroy;
begin
  inherited;
end;

procedure TModeloFast.pClear;
begin
  FFrxReport.Clear;
  FEditou := False;
end;

Function TModeloFast.fSalvaBackup(qryModelo: TUniQuery): Boolean;
  Var
    qryCadBkp: TUniQuery;
    intContador: Integer;
Begin
  Try
    qryCadBkp := fCriaQuery;

    qryCadBkp.SQL.Text := 'SELECT * FROM CADMOD WHERE FALSE';
    qryCadBkp.Open;

    qryCadBkp.Insert;

    With qryModelo Do
    Begin
      For intContador := 0 To Fields.Count - 1 Do
        qryCadBkp.Fields[intContador].Value := Fields[intContador].Value;

      qryCadBkp.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADMOD', VS_strCodEmp);
      qryCadBkp.FieldByName('MOD_CODMOD').AsString := fAtualizaProCod('CADMOD', 'MOD_CODMOD');
      qryCadBkp.FieldByName('MOD_CODBKP').AsString := FieldByName('MOD_CODMOD').AsString;
      qryCadBkp.FieldByName('MOD_DTAALT').AsDateTime := VS_Date;
      qryCadBkp.FieldByName('MOD_HORALT').AsDateTime := fTime();

      qryCadBkp.Post;
    End;

    Result := True;

    FreeAndNil(qryCadBkp);

 Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TModeloFast.fSalvaBackup]');
    End;
  End;
End;

Function TModeloFast.fRestauraBackup(qryCadMod: TUniQuery; strCodBkp: String): Boolean;
  Var
    qryModBkp: TUniQuery;
    intContador: Integer;
Begin
  Try
    Result := True;

    qryModBkp := fCriaQuery;

    qryModBkp.SQL.Text := 'SELECT * FROM CADMOD WHERE MOD_CODMOD = :CODMOD';

    With qryModBkp, SQL Do
    Begin
      ParamByName('CODMOD').AsString := strCodBkp;
      Open;

      If Not IsEmpty Then
      Begin

        For intContador := 0 To Fields.Count - 1 Do
          If Pos(Fields[intContador].FieldName, 'MOD_CODMOD-AUTOINCREM-MOD_CODBKP') <= 0 Then
            qryCadMod.Fields[intContador].Value := Fields[intContador].Value;
      End;

    End;

    FreeAndNil(qryModBkp);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TModeloFast.fRestauraBackup]');
    End;
  End;
End;

function TModeloFast.fLoadReport(blnMatricial: Boolean): Boolean;
 Var
   mmsLoad: TStream;
Begin
  Result := False;

  Try
    With FTabela Do
    Begin

      If Not FieldByName('MOD_RELFR3').IsNull Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('MOD_RELFR3'), bmRead);
        FFrxReport.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      End;

      FFrxReport.DotMatrixReport := blnMatricial;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

  FEditou := False;
End;

Function TModeloFast.fSaveReport: Boolean;
  Var
    mmsReport: TMemoryStream;
Begin
  Try

    mmsReport := TMemoryStream.Create;
    FFrxReport.SaveToStream(mmsReport);

    TBlobField(FTabela.FieldByName('MOD_RELFR3')).LoadFromStream(mmsReport);

    FreeAndNil(mmsReport);
    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TModeloFast.fSaveReport');
    End;
  End;

End;

procedure TModeloFast.pEditLayout;
begin
  FEditou := True;
  FFrxReport.DesignReport;
end;


end.
