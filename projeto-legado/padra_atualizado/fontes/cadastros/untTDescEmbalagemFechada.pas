unit untTDescEmbalagemFechada;

interface

uses
  Classes, SysUtils, StrUtils, Data.Db, untFuncoesSimples,
  System.Variants, uni, untZClient;

type
  TIteEmbDeleted = Record
    strCodIte: String;
    fltQtdEmb: Double;
  End;

  TArrIteEmbDeleted = Array of TIteEmbDeleted;

  TDescEmbalagemFechada = class
  private
    FstrCodIte : String;
    qryIteEmb: TUniQuery;
    qryCadEmp: TUniQuery;
    FcdsIteEmb: TZClient;
    arrIteEmbDel: TArrIteEmbDeleted;

    const
      SQL_CADEMP = 'SELECT EMP_CODEMP FROM CADEMP ';
      SQL_ITEEMB_INSERT = 'INSERT INTO ITEEMB (AUTOINCREM, ' +
                          'ITB_CODEMP, ' +
                          'ITB_CODITE, ' +
                          'ITB_DESCON, ' +
                          'ITB_PRIROM, ' +
                          'ITB_QTDEMB, ' +
                          'ITB_TABPRE  ' +
                          ') VALUES (' +
                          ':AUTINC, ' +
                          ':CODEMP, ' +
                          ':CODITE, ' +
                          ':DESCON, ' +
                          ':PRIROM, ' +
                          ':QTDEMB, ' +
                          ':TABPRE)';
      SQL_ITEEMB_UPDATE = 'UPDATE ITEEMB SET ITB_CODEMP = :CODEMP, ' +
                          'ITB_CODITE = :CODITE, ' +
                          'ITB_DESCON = :DESCON, ' +
                          'ITB_PRIROM = :PRIROM, ' +
                          'ITB_QTDEMB = :QTDEMB, ' +
                          'ITB_TABPRE = :TABPRE  ' +
                          'WHERE AUTOINCREM = :AUTINC';
      SQL_ITEEMB_DELETE = 'DELETE FROM ITEEMB WHERE ITB_CODITE = :CODITE AND ITB_QTDEMB = :QTDEMB AND ITB_CODEMP <> :CODEMP';

    procedure pInitQuerys;
    procedure pInitCdsIteEmb;
    procedure pDeletaTodos;
    procedure pSalvarRegistroIteEmb(strAutInc: string);
    function fPossuiRegistroEmpresa: string;
  public
    property strCodIte: String Read FstrCodIte;
    constructor Create(cdsIteEmb : TZClient; strCodIte : String);
    destructor Destroy; override;
    procedure pReplicarIteEmbEmpresas;
  end;

implementation

procedure TDescEmbalagemFechada.pInitQuerys;
begin
  qryCadEmp := fCriaQuery(nil);

  qryCadEmp.Close();
  qryCadEmp.SQL.Clear();
  qryCadEmp.SQL.Add(SQL_CADEMP);
  qryCadEmp.Open();

  qryIteEmb := fCriaQuery(nil);
end;

procedure TDescEmbalagemFechada.pInitCdsIteEmb;
begin
  FcdsIteEmb.DisableControls();
  FcdsIteEmb.Filter   := 'ITB_CODEMP = ' + VS_strCodEmp;
  FcdsIteEmb.Filtered := True;

  FcdsIteEmb.First();
end;

procedure TDescEmbalagemFechada.pDeletaTodos;
begin
  qryIteEmb.Close();
  qryIteEmb.SQL.Clear();

  qryIteEmb.SQL.Add('DELETE FROM ITEEMB');
  qryIteEmb.SQL.Add('WHERE ITB_CODITE = :CODITE');

  if FcdsIteEmb.FieldByName('ITB_CODITE').AsString <> '' then
    qryIteEmb.ParamByName('CODITE').AsString := FcdsIteEmb.FieldByName('ITB_CODITE').AsString
  else
    qryIteEmb.ParamByName('CODITE').AsString := FstrCodIte;

  qryIteEmb.ExecSQL();
end;

procedure TDescEmbalagemFechada.pSalvarRegistroIteEmb(strAutInc: string);
begin
  qryIteEmb.Close();
  qryIteEmb.SQL.Clear();

  qryIteEmb.SQL.Add(SQL_ITEEMB_INSERT);
  qryIteEmb.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEEMB', VS_strCodEmp);
  qryIteEmb.ParamByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
  qryIteEmb.ParamByName('CODITE').AsString := IfThen(FcdsIteEmb.FieldByName('ITB_CODITE').AsString = '',strCodIte,FcdsIteEmb.FieldByName('ITB_CODITE').AsString) ;
  qryIteEmb.ParamByName('DESCON').AsFloat  := FcdsIteEmb.FieldByName('ITB_DESCON').AsFloat;
  qryIteEmb.ParamByName('PRIROM').AsString := IfThen(FcdsIteEmb.FieldByName('ITB_PRIROM').AsString = '', 'N', FcdsIteEmb.FieldByName('ITB_PRIROM').AsString);
  qryIteEmb.ParamByName('QTDEMB').AsFloat  := FcdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat;
  qryIteEmb.ParamByName('TABPRE').Value    := FcdsIteEmb.FieldByName('ITB_TABPRE').Value;

  qryIteEmb.ExecSQL();
end;

function TDescEmbalagemFechada.fPossuiRegistroEmpresa: string;
begin
  Result := (fCampoTabela('AUTOINCREM',
                          'ITEEMB',
                          ['ITB_CODEMP', 'ITB_CODITE', 'ITB_QTDEMB'],
                          [qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                           FcdsIteEmb.FieldByName('ITB_CODITE').AsString,
                           FcdsIteEmb.FieldByName('ITB_QTDEMB').AsString]));
end;

constructor TDescEmbalagemFechada.Create(cdsIteEmb: TZClient; strCodIte : String);
begin
  FcdsIteEmb := cdsIteEmb;
  FstrCodIte := strCodIte;
end;

destructor TDescEmbalagemFechada.Destroy;
begin

  inherited;
end;

procedure TDescEmbalagemFechada.pReplicarIteEmbEmpresas;
begin
  try
    pInitQuerys();

    try
      pInitCdsIteEmb();
      // Deleta todos;
      pDeletaTodos;

      while (not FcdsIteEmb.Eof) do
      begin
        qryCadEmp.First();

        while (not qryCadEmp.Eof) do
        begin
          // if (not fRegistroAlterado()) then
          pSalvarRegistroIteEmb(fPossuiRegistroEmpresa());
          // else
          //   pSalvarRegistroIteEmb(fConsultaRegistroEmpresa());

          qryCadEmp.Next();
        end;

        FcdsIteEmb.Next();
      end;

      // pDeletarRegistros();

      SetLength(arrIteEmbDel, 0);
    except
      on E: Exception do
        pMensagensErro(E.Message, '[TDescEmbalagemFechada.pReplicarIteEmbEmpresas]');
    end;
  finally
    FcdsIteEmb.Filter := '';
    FcdsIteEmb.Filtered := False;
    FcdsIteEmb.EnableControls();

    FreeAndNil(qryCadEmp);
    FreeAndNil(qryIteEmb);
  end;
end;
end.

