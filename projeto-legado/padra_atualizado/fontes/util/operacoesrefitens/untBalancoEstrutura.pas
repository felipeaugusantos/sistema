unit untBalancoEstrutura;


interface

Uses
  Classes,
  SysUtils,
  Controls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient,
  strUtils;

Type

  TBalancoEstrutura = Class(TZClient)
    Private

      Function fSQLItens: String;

    Public
      strCodIte,
      strDIGBAL: String;
      blnDVQBAL: Boolean;
      intBXSBIT: Integer;

      fltQtdIte: Double;

      constructor Create(Owner: TComponent); Reintroduce;

      Function fEhEtiquetaEstrutura(strInfo: String): Boolean;
      Function fCarregaItens(strCodIte: String): Boolean;
  End;


implementation

uses untFuncoesSimples;

constructor TBalancoEstrutura.Create(Owner: TComponent);
Begin
  intBXSBIT := fCfgSis('BXSBIT', varInteger);
  strDIGBAL := fCfgSis('DIGBAL');
  blnDVQBAL := fCfgSis('DVQBAL', varBoolean);

  Inherited Create(Owner, fSQLItens);
End;

Function TBalancoEstrutura.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   DMT_ITESUB AS CODITE, ';
  strSQL := strSQL + '   DMT_QTDITE * :QTDCON  ';

  If blnDVQBAL Then
    strSQL := strSQL + '  / 1000  ';

  strSQL := strSQL + '  AS QTDITE ';

  strSQL := strSQL + '  FROM GERMAT ';
  strSQL := strSQL + '  INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM ';

  strSQL := strSQL + '  WHERE GMT_CODITE = :CODITE ';

  Result := strSQL;
End;

Function TBalancoEstrutura.fCarregaItens(strCodIte: String): Boolean;
Begin
  Result := fLeDados('TBalancoEstrutura.fCarregaItens');
End;

Function TBalancoEstrutura.fEhEtiquetaEstrutura(strInfo: String): Boolean;
Begin
  Result := (intBXSBIT = 2) And
            (Not strDIGBAL.IsEmpty) And
            (strInfo.Length = 13) And
            strInfo.StartsWith(strDIGBAL);

  If Not Result Then
    Exit;

  strCodIte := Copy(strInfo, 3, 5);

  fltQtdIte := fStrToFloat(Copy(strInfo, 8, 5));

  If fltQtdIte = 0 Then
  Begin
    Result := False;
    Exit;
  End;

  qryQuery.ParamByName('CODITE').AsString := strCodIte;
  qryQuery.ParamByName('QTDCON').AsFloat  := fltQtdIte;

  Result := fCarregaItens(strCodIte) And (Not Self.IsEmpty);
End;

end.
