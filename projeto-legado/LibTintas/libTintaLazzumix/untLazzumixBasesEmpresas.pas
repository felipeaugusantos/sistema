unit untLazzumixBasesEmpresas;

interface

uses Classes, StrUtils, SysUtils, Forms,UniClientDataSet,untAutcomTintaFactory,
     ComCtrls, frxClass, Variants, untIDataSet, untStrUtils;

Type

  TLazzumixBasEmp = Class(TComponent)
  Private
    qryCadEmp: IDataSet;

    FCodBas: String;
    FDesBas: String;
    FBasEpo: String;
    FEmbala: Double;
    FPesEsp: Double;

    procedure pSelecionaEmpresas;
    procedure pCarregaBasesEmp(Var qryBases: IDataSet);
    procedure pDeletaBases(strCodBas: String);
    function fInsertBasEmp: String;
    procedure pSetaParametros(qryIns: IDataSet; cdsBases: TUniClientDataSet);
    procedure pAtualizaCnvMl(strCodIte: String);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    property strCodBas: String Read FCodBas   Write FCodBas;
    property strDesBas: String Read FDesBas   Write FDesBas;
    property strBasEpo: String Read FBasEpo   Write FBasEpo;
    property fltEmbala: Double Read FEmbala   Write FEmbala;
    property fltPesEsp: Double Read FPesEsp   Write FPesEsp;

    procedure pPreencheClientBases(cdsBases: TUniClientDataSet);
    function fProdutosPreenchidos(cdsBases: TUniClientDataSet): Boolean;
    procedure pGravaBasesEmp(cdsBases: TUniClientDataSet);
  End;

implementation


{ TLazzumixBasEmp }

constructor TLazzumixBasEmp.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  qryCadEmp := TAutcomTintaFactory.Get.fGetDataSet;

  pSelecionaEmpresas;
end;

destructor TLazzumixBasEmp.Destroy;
begin
  FreeAndNil(qryCadEmp);

  inherited Destroy;
end;

procedure TLazzumixBasEmp.pGravaBasesEmp(cdsBases: TUniClientDataSet);
var
  qryIns: IDataSet;
begin
  Try
    Try
      qryIns := TAutcomTintaFactory.Get.fGetDataSet;
      qryIns.SQL := fInsertBasEmp;

      pDeletaBases(FCodBas);

      cdsBases.First;

      While Not cdsBases.Eof Do
      Begin

        pSetaParametros(qryIns, cdsBases);

        Try
          qryIns.ExecSQL;
        Except
        On e : Exception Do
          TAutcomTintaFactory.Get.fMensagem('AVISO', e.Message,['&Ok']);
        End;

        pAtualizaCnvMl(cdsBases.FieldByName('CODITE').AsString);

        cdsBases.Next;
      End;
    except
      TAutcomTintaFactory.Get.fMensagem('Atenção','Erro ao gravar as bases!',['&Ok']);
    End;
  Finally
    TAutcomTintaFactory.Get.fMensagem('Informação','As bases foram cadastradas com sucesso !',['&Ok']);
  End;

end;

function TLazzumixBasEmp.fInsertBasEmp: String;
begin
  Result := '';
  Result := Result + ' INSERT INTO LAZ_BASEMP ';
  Result := Result + '    ( ';
  Result := Result + '      BAS_CODBAS, ';
  Result := Result + '      BAS_CODEMP, ';
  Result := Result + '      BAS_CODITE, ';
  Result := Result + '      BAS_EMBALA, ';
  Result := Result + '      BAS_PESESP  ';
  Result := Result + '    ) ';
  Result := Result + '      VALUES      ';
  Result := Result + '    ( ';
  Result := Result + '      :CODBAS,    ';
  Result := Result + '      :CODEMP,    ';
  Result := Result + '      :CODITE,    ';
  Result := Result + '      :EMBALA,    ';
  Result := Result + '      :PESESP     ';
  Result := Result + '    ); ';
end;

function TLazzumixBasEmp.fProdutosPreenchidos(cdsBases: TUniClientDataSet): Boolean;
begin
  Result := False;

  cdsBases.First;

  While Not cdsBases.Eof Do
  Begin
    If (Not TStrUtils.fEmptyStr(cdsBases.FieldByName('CODITE').AsString)) Then
    Begin
      Result := True;
      Break;
    End;

    cdsBases.Next;
  End;

  If Not Result Then
    TAutcomTintaFactory.Get.fMensagem('Informação','Nenhum produto foi informado! ',['&Ok']);
end;

procedure TLazzumixBasEmp.pAtualizaCnvMl(strCodIte: String);
Var
  qryGen: IDataSet;
  fltEmbalagem: Double;
begin
  If (Not TStrUtils.fEmptyStr(strCodIte)) Then
  Begin
    fltEmbalagem := (FEmbala * FPesEsp);

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' UPDATE CADITE ' +
                  '    SET ITE_CNV_ML = ' + AnsiReplaceStr(FloatToStr(fltEmbalagem), ',', '.') + ' ' +
                  '  WHERE ITE_CODITE = :CODITE ';

    qryGen.ParamByName('CODITE').AsString := strCodIte;

    qryGen.ExecSQL;
  End;
end;

procedure TLazzumixBasEmp.pCarregaBasesEmp(Var qryBases: IDataSet);
begin
  qryBases.SQL := ' SELECT SQL_NO_CACHE ' +
                  '        BAS_CODBAS,  '+
                  '        BAS_CODITE,  '+
                  '        BAS_EMBALA AS EMBALA,  '+
                  '        BAS_PESESP AS PESESP,  '+
                  '        ITE_DESITE,  '+
                  '        EMP_CODEMP,  '+
                  '        EMP_NOMEMP   '+
                  '   FROM CADEMP   '+
                  '   LEFT JOIN LAZ_BASEMP ON BAS_CODEMP = EMP_CODEMP '+
                  '                       AND BAS_CODBAS = :CODBAS '+
                  '   LEFT JOIN CADITE ON ITE_CODITE = BAS_CODITE '+
                  '   ORDER BY EMP_CODEMP ';
  qryBases.ParamByName('CODBAS').AsString := FCodBas;
  qryBases.Open;
end;

procedure TLazzumixBasEmp.pDeletaBases(strCodBas: String);
var
  qryDel: IDataSet;
begin
  qryDel := TAutcomTintaFactory.Get.fGetDataSet;

  qryDel.SQL := ' DELETE '+
                '   FROM LAZ_BASEMP '+
                '  WHERE BAS_CODBAS = :CODBAS ';
  qryDel.ParamByName('CODBAS').AsString := FCodBas;
  qryDel.ExecSQL;
end;

procedure TLazzumixBasEmp.pPreencheClientBases(cdsBases: TUniClientDataSet);
var
  qryBases: IDataSet;
begin
  qryBases := TAutcomTintaFactory.Get.fGetDataSet;

  pCarregaBasesEmp(qryBases);


  qryBases.First;

  While Not qryBases.Eof Do
  Begin
    cdsBases.Append;
    cdsBases.FieldByName('CODBAS').AsString := FCodBas;
    cdsBases.FieldByName('DESBAS').AsString := FDesBas;
    cdsBases.FieldByName('EMBALA').AsFloat := qryBases.FieldByName('EMBALA').AsFloat;
    cdsBases.FieldByName('PESESP').AsFloat := qryBases.FieldByName('PESESP').AsFloat;
    cdsBases.FieldByName('CODEMP').AsString := qryBases.FieldByName('EMP_CODEMP').AsString;
    cdsBases.FieldByName('NOMEMP').AsString := qryBases.FieldByName('EMP_NOMEMP').AsString;
    cdsBases.FieldByName('CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;
    cdsBases.FieldByName('DESITE').AsString := qryBases.FieldByName('ITE_DESITE').AsString;
    cdsBases.Post;

    qryBases.Next;
  End;

end;

procedure TLazzumixBasEmp.pSelecionaEmpresas;
begin
  qryCadEmp.Close;
  qryCadEmp.SQL := ' SELECT * '+
                   '   FROM CADEMP '+
                   '  ORDER BY EMP_CODEMP ';
  qryCadEmp.Open;
end;

procedure TLazzumixBasEmp.pSetaParametros(qryIns: IDataSet ; cdsBases: TUniClientDataSet);
begin
  qryIns.ParamByName('CODBAS').AsString := cdsBases.FieldByName('CODBAS').AsString;
  qryIns.ParamByName('CODEMP').AsString := cdsBases.FieldByName('CODEMP').AsString;

  If TStrUtils.fEmptyStr(cdsBases.FieldByName('CODITE').AsString) Then
    qryIns.ParamByName('CODITE').Value := Null
  Else
    qryIns.ParamByName('CODITE').AsString := cdsBases.FieldByName('CODITE').AsString;

  qryIns.ParamByName('EMBALA').AsFloat := cdsBases.FieldByName('EMBALA').AsFloat;
  qryIns.ParamByName('PESESP').AsFloat := FPesEsp;

  FEmbala := cdsBases.FieldByName('EMBALA').AsFloat;
end;

end.
