{*********************************************************}
{* CLASSE PARA O CADASTRO DE FERIADOS                    *}
{*                                                       *}
{* DATA......: 11/05/2009                                *}
{* AUTOR.....: LUCIENE COVRE BOROTTO                     *}
{*                                                       *}
{******************************************************LU*}
unit untCadFer;

interface

uses Classes, DB, untFuncoesSimples, Uni;

Type TCadFer = Class (TComponent)
  Private
    FDtaFer: TDateTime;
    FDescri: String;
    FCodEmp: String;
    FAutInc: String;

    function getDtaFer: string;

    procedure setDtaFer(const Value: string);
    procedure setDescri(const Value: String);
    procedure pAfterOpen(Dataset: TDataSet);
    function fGetAutoIncremByData(dtaFer: TDateTime): String;
  Public

    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strDescri: String Read FDescri   Write setDescri;
    Property strDtaFer: string Read getDtaFer Write setDtaFer;
    Property strCodEmp: String Read FCodEmp   Write FCodEmp;
    Property strAutInc: String Read FAutInc   Write FAutInc;

    Constructor Create(Owner: TComponent); Reintroduce;

    function fVerificaDataExiste(dtaData: TDateTime): Boolean;
    function fExisteFerByAno(strAno: String): Boolean;
    function fGeraFeriadoByAnoBaseToNovoAno(strAnoBase, strNovoAno: String): Boolean;
  end;

Const
  arrCampos:  array[0..3] of String =   ('FER_DTAFER','FER_DESCRI','FER_CODEMP','AUTOINCREM');


  arrDescricao: array[0..3] of String = ('Data','Descrição','Empresa','AUTOINCREM');

  arrTipo:  array[0..3] of TFieldType = (ftDate,ftString,ftString,ftString);


  arrTamanhos: array[0..3] of Integer = (0,40,3,20);


  arrVisible:  array[0..3] of Boolean = (True,True,False,False);

  arrFormat:   array[0..3] of String  = ('99/99/9999;1;_','','','');

implementation

{ TCadFer }

uses SysUtils;

function TCadFer.getDtaFer: string;
begin
  Result := FormatDateTime('dd/mm/yyyy',FDtaFer);
end;

procedure TCadFer.setDtaFer(const Value: string);
begin

  If Not fEmptyStr(fTiraCaracEspeciais(Value)) Then
    FDtaFer := StrToDateTime(Value)
  Else
    Raise Exception.Create('A Data deve ser preenchida!');

end;

procedure TCadFer.setDescri(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FDescri := Value
  Else
    Raise Exception.Create('A Descrição deve ser preenchida!');

end;

constructor TCadFer.Create(Owner: TComponent);
  Var
    IntContador: Integer;
begin

  Try
    SetLength(arrDefCam,4);

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam := arrCampos[intContador];
      arrDefCam[intContador].strDesCri := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam := arrTipo[intContador];
      arrDefCam[intContador].intTamCam := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible:= arrVisible[intContador];
      arrDefCam[intContador].strFormat := arrFormat[intContador];
    End;

    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADFER WHERE FALSE');
    qryTabela.Open;

    FDtaFer := 0;
    FDescri := '';
    FCodEmp := '';
    FAutInc := '';

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadFer!' + #13 + E.Message);

  End;

end;

procedure TCadFer.pAfterOpen(Dataset: TDataSet);
begin
  TDateField(qryTabela.FieldByName('FER_DTAFER')).EditMask := '99/99/9999;1;_';
end;

function TCadFer.fExisteFerByAno(strAno: String): Boolean;
Var
  qryGen : TUniQuery;
  strSQL : String;
Begin
  Result := False;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DATE_FORMAT(FER_DTAFER, "%Y") = :ANOFER '; // AND ';
//    strSQL := strSQL + '   FER_CODEMP = :CODEMP ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ANOFER').AsString := strAno;
//      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True
      Else
        Result := False;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadFer.fExisteFerByAno]');
    End;
  End;

  FreeAndNil(qryGen);
end;

function TCadFer.fGeraFeriadoByAnoBaseToNovoAno(strAnoBase,
  strNovoAno: String): Boolean;
Var
  qryGen : TUniQuery;
  qryCad : TUniQuery; 
  strSQL : String;
  dtaTmp : TDateTime;

  strAutoIncrem: String;
begin
  Result := False;

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DATE_FORMAT(FER_DTAFER, "%Y") = :ANOFER '; //AND ';
//    strSQL := strSQL + '   FER_CODEMP = :CODEMP ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ANOFER').AsString := strAnoBase;
//      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        First;

        qryCad := fCriaQuery;

        While Not Eof Do
        Begin
          dtaTmp := StrToDateTime(FormatDateTime('dd/mm', FieldByName('FER_DTAFER').AsDateTime) + '/' + strNovoAno);

          If fVerificaDataExiste(dtaTmp) Then
            strAutoIncrem := fGetAutoIncremByData(dtaTmp)
          Else
            strAutoIncrem := fRetAutoIncrem('CADFER', VS_strCodEmp);
            
          strSQL := '';
          strSQL := strSQL + 'REPLACE INTO CADFER (';
          strSQL := strSQL + '  FER_CODEMP, ';
          strSQL := strSQL + '  FER_DTAFER, ';
          strSQL := strSQL + '  FER_DESCRI, ';
          strSQL := strSQL + '  AUTOINCREM) ';
          strSQL := strSQL + 'VALUES ( ';
          strSQL := strSQL + '  :CODEMP, ';
          strSQL := strSQL + '  :DTAFER, ';
          strSQL := strSQL + '  :DESCRI, ';
          strSQL := strSQL + '  :AUTOINCREM) ';

          qryCad.Close;
          qryCad.SQL.Clear;
          qryCad.SQL.Add(strSQL);

          qryCad.ParamByName('CODEMP').AsString     := FieldByName('FER_CODEMP').AsString;
          qryCad.ParamByName('DTAFER').AsDateTime   := dtaTmp;
          qryCad.ParamByName('DESCRI').AsString     := FieldByName('FER_DESCRI').AsString;
          qryCad.ParamByName('AUTOINCREM').AsString := strAutoIncrem;

          qryCad.ExecSQL;

          Next;
        End;

        Result := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadFer.fGeraFeriadoByAnoBaseToNovoAno]');
    End;
  End;

  FreeAndNil(qryGen);

  If Assigned(qryCad) Then
    FreeAndNil(qryCad);
end;

function TCadFer.fGetAutoIncremByData(dtaFer: TDateTime): String;
Var
  qryGen : TUniQuery;
  strSQL : String;
Begin
  Result := '';
  
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   AUTOINCREM ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FER_DTAFER = :DTAFER AND ';
    strSQL := strSQL + '   FER_CODEMP = :CODEMP ';
    strSQL := strSQL + ' LIMIT 1 ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAFER').AsDateTime := dtaFer;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      Open;

      Result := FieldByName('AUTOINCREM').AsString;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadFer.fGetAutoIncremByData]');
    End;
  End;

  FreeAndNil(qryGen);
end;

function TCadFer.fVerificaDataExiste(dtaData: TDateTime): Boolean;
Var
  qryGen : TUniQuery;
  strSQL : String;
Begin
  Result := false;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FER_DTAFER = :DTAFER AND ';
    strSQL := strSQL + '   FER_CODEMP = :CODEMP ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAFER').AsDateTime := dtaData;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True
      Else
        Result := False;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadFer.fVerificaDataExiste]');
    End;
  End;

  FreeAndNil(qryGen);
End;

end.

