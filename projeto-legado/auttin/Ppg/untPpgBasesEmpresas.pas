unit untPpgBasesEmpresas;

interface

uses Classes, StrUtils, SysUtils, UniClientDataSet, Uni, Provider, DB, Forms,
     ComCtrls, frxClass, Variants;


Type

  TPpgBasEmp = Class(TComponent)
  Private
    qryCadEmp: TUniQuery;

    FCodBas: String;
    FDesBas: String;
    FBasEpo: String;
    FEmbala: Double;
    FPesEsp: Double;

    procedure pSelecionaEmpresas;
    procedure pCarregaBasesEmp(Var qryBases: TUniQuery);
    procedure pDeletaBases(strCodBas: String);
    function fInsertBasEmp: String;
    procedure pSetaParametros(qryIns: TUniQuery; cdsBases: TUniClientDataSet);
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

uses untFuncoesSimples;

{ TPpgBasEmp }

constructor TPpgBasEmp.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  qryCadEmp := fCriaQuery;

  pSelecionaEmpresas;
end;

destructor TPpgBasEmp.Destroy;
begin
  FreeAndNil(qryCadEmp);

  inherited Destroy;
end;

procedure TPpgBasEmp.pGravaBasesEmp(cdsBases: TUniClientDataSet);
var
  qryIns: TUniQuery;
begin
  Try
    Try
      qryIns := fCriaQuery;
      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fInsertBasEmp);
      End;

      fStartTransaction;

      pDeletaBases(FCodBas);

      cdsBases.First;
      While Not cdsBases.Eof Do
      Begin

        pSetaParametros(qryIns, cdsBases);

        qryIns.ExecSQL;

        pAtualizaCnvMl(cdsBases.FieldByName('CODITE').AsString);

        cdsBases.Next;
      End;

      fCommit;
      fMensagem('Informação','As bases foram cadastradas com sucesso !',['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[fGravaBasesEmp]');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

function TPpgBasEmp.fInsertBasEmp: String;
begin
  Result := '';
  Result := Result + ' INSERT INTO PPG_BASEMP ';
  Result := Result + '    ( ';
  Result := Result + '      BAS_CODBAS, ';
  Result := Result + '      BAS_CODEMP, ';
  Result := Result + '      BAS_CODITE  ';
  Result := Result + '    ) ';
  Result := Result + '      VALUES      ';
  Result := Result + '    ( ';
  Result := Result + '      :CODBAS,    ';
  Result := Result + '      :CODEMP,    ';
  Result := Result + '      :CODITE     ';
  Result := Result + '    ); ';
end;

function TPpgBasEmp.fProdutosPreenchidos(cdsBases: TUniClientDataSet): Boolean;
begin
  Result := False;

  cdsBases.First;
  While Not cdsBases.Eof Do
  Begin
    If (Not fEmptyStr(cdsBases.FieldByName('CODITE').AsString)) Then
    Begin
      Result := True;
      Break;
    End;

    cdsBases.Next;
  End;

  If Not Result Then
    fMensagem('Informação','Nenhum produto foi informado! ',['&Ok']);
end;

procedure TPpgBasEmp.pAtualizaCnvMl(strCodIte: String);
  Var
    qryGen: TUniQuery;
begin
  If (Not fEmptyStr(strCodIte)) Then
  Begin
    Try
      qryGen := fCriaQuery(Self);
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE CADITE ');
        SQL.Add('    SET ITE_CNV_ML = :CNV_ML ');
        SQL.Add('  WHERE ITE_CODITE = :CODITE ');

        ParamByName('CNV_ML').AsFloat  := (FEmbala * IIF(FBasEpo = 'S', 1, FPesEsp));
        ParamByName('CODITE').AsString := strCodIte;

        ExecSQL;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TPpgBasEmp.pCarregaBasesEmp(var qryBases: TUniQuery);
begin
  With qryBases Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SQL_NO_CACHE ');
    SQL.Add('        BAS_CODBAS,  ');
    SQL.Add('        BAS_CODITE,  ');
    SQL.Add('        ITE_DESITE,  ');
    SQL.Add('        EMP_CODEMP,  ');
    SQL.Add('        EMP_NOMEMP   ');
    SQL.Add('   FROM CADEMP   ');
    SQL.Add('   LEFT JOIN PPG_BASEMP ON BAS_CODEMP = EMP_CODEMP ');
    SQL.Add('                       AND BAS_CODBAS = :CODBAS ');
    SQL.Add('   LEFT JOIN CADITE ON ITE_CODITE = BAS_CODITE ');
    SQL.Add('   ORDER BY EMP_CODEMP ');
    ParamByName('CODBAS').AsString := FCodBas;
    Open;
  End;
end;

procedure TPpgBasEmp.pDeletaBases(strCodBas: String);
var
  qryDel: TUniQuery;
begin
  Try
    qryDel := fCriaQuery;
    With qryDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM PPG_BASEMP WHERE BAS_CODBAS = :CODBAS ');
      ParamByName('CODBAS').AsString := FCodBas;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryDel);
  End;
end;

procedure TPpgBasEmp.pPreencheClientBases(cdsBases: TUniClientDataSet);
var
  qryBases: TUniQuery;
begin
  Try
    qryBases := fCriaQuery;

    pCarregaBasesEmp(qryBases);

    With cdsBases Do
    Begin
      qryBases.First;
      While Not qryBases.Eof Do
      Begin
        Append;
        FieldByName('CODBAS').AsString := FCodBas;
        FieldByName('DESBAS').AsString := FDesBas;
        FieldByName('CODEMP').AsString := qryBases.FieldByName('EMP_CODEMP').AsString;
        FieldByName('NOMEMP').AsString := qryBases.FieldByName('EMP_NOMEMP').AsString;
        FieldByName('CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;
        FieldByName('DESITE').AsString := qryBases.FieldByName('ITE_DESITE').AsString;
        Post;

        qryBases.Next;
      End;
    End;
  Finally
    FreeAndNil(qryBases);
  End;
end;

procedure TPpgBasEmp.pSelecionaEmpresas;
begin
  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SQL_NO_CACHE * FROM CADEMP ORDER BY EMP_CODEMP ');
    Open;
  End;
end;

procedure TPpgBasEmp.pSetaParametros(qryIns: TUniQuery; cdsBases: TUniClientDataSet);
begin
  With qryIns Do
  Begin
    ParamByName('CODBAS').AsString := cdsBases.FieldByName('CODBAS').AsString;
    ParamByName('CODEMP').AsString := cdsBases.FieldByName('CODEMP').AsString;
    If fEmptyStr(cdsBases.FieldByName('CODITE').AsString) Then
      ParamByName('CODITE').Value := Null
    Else
      ParamByName('CODITE').AsString := cdsBases.FieldByName('CODITE').AsString;
  End;
end;

end.
