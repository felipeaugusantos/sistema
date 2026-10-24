unit untEmpSoc;

interface

uses SysUtils, untFuncoes, untfuncoesSimples, Uni, Contnrs, DB;

Type
    TEmpSoc = class(TObject)
      private
        FCodEmp: String;
        FNomSoc: String;
        FProfis: String;
        FEstCiv: String;
        FCidSoc: String;
        FCgcCpf: String;
        FNumCgc: String;
        FRg_Ies: String;
        FOrgEmi: String;
        FNomCid: String;
        FEstado: String;

        qryEmpSoc: TUniQuery;

        procedure pZeraValores;

      protected
        function getCodEmp: String;
        function getNomSoc: String;
        function getProfis: String;
        function getEstCiv: String;
        function getCidSoc: String;
        function getCgcCpf: String;
        function getNumCgc: String;
        function getRg_Ies: String;
        function getOrgEmi: String;

        procedure setCodEmp(const Value: String);
        procedure setNomSoc(const Value: String);
        procedure setProfis(const Value: String);
        procedure setEstCiv(const Value: String);
        procedure setCidSoc(const Value: String);
        procedure setCgcCpf(const Value: String);
        procedure setNumCgc(const Value: String);
        procedure setRg_Ies(const Value: String);
        procedure setOrgEmi(const Value: String);

      public

        Constructor Create; reintroduce; overload;
        Constructor Create(Const strCodEmp, strAutInc: String); overload;
        Destructor Destroy; override;

        procedure pInsereEmpSoc;
        class procedure pApagarEmpSoc(const strCodEmp: String);
        class function fRetSocios(const strCodEmp: String): TObjectList;

        property strCodEmp: String Read getCodEmp Write setCodEmp;
        property strNomSoc: String Read getNomSoc Write setNomSoc;
        property strProfis: String Read getProfis Write setProfis;
        property strEstCiv: String Read getEstCiv Write setEstCiv;
        property strCidSoc: String Read getCidSoc Write setCidSoc;
        property strCgcCpf: String Read getCgcCpf Write setCgcCpf;
        property strNumCgc: String Read getNumCgc Write setNumCgc;
        property strRg_Ies: String Read getRg_Ies Write setRg_Ies;
        property strOrgEmi: String Read getOrgEmi Write setOrgEmi;
        property strNomCid: String Read FNomCid;
        property strEstado: String Read FEstado;
End;

implementation

{ TEmpSoc }

constructor TEmpSoc.Create;
begin
  qryEmpSoc := fCriaQuery(Nil);
  pZeraValores;
end;

constructor TEmpSoc.Create(const strCodEmp, strAutInc: String);
  Var
    qryAux: TUniQuery;
begin
  qryEmpSoc := fCriaQuery(Nil);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                                   ');
  qryAux.SQL.Add('  *                                      ');
  qryAux.SQL.Add('FROM                                     ');
  qryAux.SQL.Add('  EMPSOC                                 ');
  qryAux.SQL.Add('  JOIN CADCID ON CID_CODCID = EMP_CIDSOC ');
  qryAux.SQL.Add('WHERE                                    ');
  qryAux.SQL.Add('  EMP_CODEMP = :CODEMP AND               ');
  qryAux.SQL.Add('  EMPSOC.AUTOINCREM = :AUTINC            ');

  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    pZeraValores;
  End
  Else
  Begin
    FCodEmp := qryAux.FieldByName('EMP_CODEMP').AsString;
    FNomSoc := qryAux.FieldByName('EMP_NOMSOC').AsString;
    FProfis := qryAux.FieldByName('EMP_PROFIS').AsString;
    FEstCiv := qryAux.FieldByName('EMP_ESTCIV').AsString;
    FCidSoc := qryAux.FieldByName('EMP_CIDSOC').AsString;
    FCgcCpf := qryAux.FieldByName('EMP_CGCCPF').AsString;
    FNumCgc := qryAux.FieldByName('EMP_C_G_C_').AsString;
    FRg_Ies := qryAux.FieldByName('EMP_RG_IES').AsString;
    FOrgEmi := qryAux.FieldByName('EMP_ORGEMI').AsString;
    FNomCid := qryAux.FieldByName('CID_NOMCID').AsString;
    FEstado := qryAux.FieldByName('CID_ESTADO').AsString;
  End;
end;

destructor TEmpSoc.Destroy;
begin

  inherited;
end;

class function TEmpSoc.fRetSocios(const strCodEmp: String): TObjectList;
  Var
    qryAux: TUniQuery;
begin

  Result := TObjectList.Create(True);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add(' SELECT AUTOINCREM FROM EMPSOC WHERE EMP_CODEMP = :CODEMP ');
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TEmpSoc.Create(strCodEmp, qryAux.FieldByName('AUTOINCREM').AsString));
    qryAux.Next;
  End;
  qryAux.Close;

  FreeAndNil(qryAux);

end;

function TEmpSoc.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TEmpSoc.getNomSoc: String;
begin
  Result := FNomSoc;
end;

function TEmpSoc.getProfis: String;
begin
  Result := FProfis;
end;

function TEmpSoc.getEstCiv: String;
begin
  Result := FEstCiv;
end;

function TEmpSoc.getCidSoc: String;
begin
  Result := FCidSoc;
end;

function TEmpSoc.getCgcCpf: String;
begin
  Result := FCgcCpf;
end;

function TEmpSoc.getNumCgc: String;
begin
  Result := FNumCgc;
end;

function TEmpSoc.getRg_Ies: String;
begin
  Result := FRg_Ies;
end;

function TEmpSoc.getOrgEmi: String;
begin
  Result := FOrgEmi;
end;

class procedure TEmpSoc.pApagarEmpSoc(const strCodEmp: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add(' DELETE FROM EMPSOC WHERE EMP_CODEMP = :CODEMP ');
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TEmpSoc.pInsereEmpSoc;
begin
  setCodEmp(FCodEmp);
  setNomSoc(FNomSoc);
  setProfis(FProfis);
  setEstCiv(FEstCiv);
  setCidSoc(FCidSoc);
  setCgcCpf(FCgcCpf);
  setNumCgc(FNumCgc);
  setRg_Ies(FRg_Ies);
  setOrgEmi(FOrgEmi);

  qryEmpSoc.Close;
  qryEmpSoc.SQL.Clear;
  qryEmpSoc.SQL.Add('INSERT INTO EMPSOC  ');
  qryEmpSoc.SQL.Add('(                   ');
  qryEmpSoc.SQL.Add('  EMP_CODEMP,       ');
  qryEmpSoc.SQL.Add('  EMP_NOMSOC,       ');
  qryEmpSoc.SQL.Add('  EMP_PROFIS,       ');
  qryEmpSoc.SQL.Add('  EMP_ESTCIV,       ');
  qryEmpSoc.SQL.Add('  EMP_CIDSOC,       ');
  qryEmpSoc.SQL.Add('  EMP_CGCCPF,       ');
  qryEmpSoc.SQL.Add('  EMP_C_G_C_,       ');
  qryEmpSoc.SQL.Add('  EMP_RG_IES,       ');
  qryEmpSoc.SQL.Add('  EMP_ORGEMI,       ');
  qryEmpSoc.SQL.Add('  AUTOINCREM        ');
  qryEmpSoc.SQL.Add(') VALUES (          ');
  qryEmpSoc.SQL.Add('  :CODEMP,          ');
  qryEmpSoc.SQL.Add('  :NOMSOC,          ');
  qryEmpSoc.SQL.Add('  :PROFIS,          ');
  qryEmpSoc.SQL.Add('  :ESTCIV,          ');
  qryEmpSoc.SQL.Add('  :CIDSOC,          ');
  qryEmpSoc.SQL.Add('  :CGCCPF,          ');
  qryEmpSoc.SQL.Add('  :C_G_C_,          ');
  qryEmpSoc.SQL.Add('  :RG_IES,          ');
  qryEmpSoc.SQL.Add('  :ORGEMI,          ');
  qryEmpSoc.SQL.Add('  :AUTINC)          ');

  qryEmpSoc.ParamByName('CODEMP').AsString := FCodEmp;
  qryEmpSoc.ParamByName('NOMSOC').AsString := FNomSoc;
  qryEmpSoc.ParamByName('PROFIS').AsString := FProfis;
  qryEmpSoc.ParamByName('ESTCIV').AsString := FEstCiv;
  qryEmpSoc.ParamByName('CIDSOC').AsString := FCidSoc;
  qryEmpSoc.ParamByName('CGCCPF').AsString := FCgcCpf;
  qryEmpSoc.ParamByName('C_G_C_').AsString := FNumCgc;
  qryEmpSoc.ParamByName('RG_IES').AsString := FRg_Ies;
  qryEmpSoc.ParamByName('ORGEMI').AsString := FOrgEmi;
  qryEmpSoc.ParamByName('AUTINC').AsString := fRetAutoIncrem('EMPSOC', FCodEmp);
  qryEmpSoc.ExecSQL;
  qryEmpSoc.Close;

end;

procedure TEmpSoc.pZeraValores;
begin
  FCodEmp := '';
  FNomSoc := '';
  FProfis := '';
  FEstCiv := '';
  FCidSoc := '';
  FCgcCpf := '';
  FNumCgc := '';
  FRg_Ies := '';
  FOrgEmi := '';
  FNomCid := '';
  FEstado := '';
end;

procedure TEmpSoc.setCodEmp(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('A Empresa deve ser preenchida!');

  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TEmpSoc.setNomSoc(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('O Nome deve ser preenchido!');

  If (FNomSoc <> Value) Then
    FNomSoc := Value;
end;

procedure TEmpSoc.setProfis(const Value: String);
begin
  If (FProfis <> Value) Then
    FProfis := Value;
end;

procedure TEmpSoc.setEstCiv(const Value: String);
begin
  If (FEstCiv <> Value) Then
    FEstCiv := Value;
end;

procedure TEmpSoc.setCidSoc(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('A Cidade deve ser preenchida!');

  FNomCid := fRetNomCidade(Value);
  If (fEmptyStr(FNomCid)) Then
    pRaise('Essa cidade não está cadastrada!');

  FEstado := fRetNomCidade(Value, 1);

  If (FCidSoc <> Value) Then
    FCidSoc := Value;
end;

procedure TEmpSoc.setCgcCpf(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('O Tipo de Documento deve ser preenchido!');

  If (Pos(Value, '1_2_') <= 0) Then
    pRaise('O Tipo deve ser 1 ou 2!');

  If Value = '1' Then
    TStringField(qryEmpSoc.FieldByName('EMP_C_G_C_')).EditMask := '>aa\.aaa\.aaa/aaaa-99;1;_'
  Else
    TStringField(qryEmpSoc.FieldByName('EMP_C_G_C_')).EditMask := '999.999.999-99;1;_';

  If (FCgcCpf <> Value) Then
    FCgcCpf := Value;
end;

procedure TEmpSoc.setNumCgc(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('O CPF/CGC deve ser preenchido!');

  If (FNumCgc <> Value) Then
    FNumCgc := Value;
end;

procedure TEmpSoc.setRg_Ies(const Value: String);
begin
  If (FRg_Ies <> Value) Then
    FRg_Ies := Value;
end;

procedure TEmpSoc.setOrgEmi(const Value: String);
begin
  If (FOrgEmi <> Value) Then
    FOrgEmi := Value;
end;

end.
