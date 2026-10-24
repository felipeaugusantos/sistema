unit untStarmix;

interface

uses SysUtils, Uni, Forms, Classes, StrUtils, untFuncoesSimples;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fConsultaStarmix(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaStarmixGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaStarmixVenda(Sender: TForm; strCodEmp: String;
    Var qryCadSta: TUniQuery): String; stdcall;

  function fRetornaPrecoStarmix(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaDescricaoStarmix(qryCadSta: TUniQuery): String;

  function fRetornaUniTraProStarmix(qryCadSta: TUniQuery; fltPreEmb,
    fltQuanti: Double; strIteTin: String): Double;

  function fRetornaUniTraEmbStarmix(strTipEmb: String): Double;

  procedure pRetornaDadosStarmix(strIteTin: String; dicRetorno: TDicionario);


implementation

uses untConsultaCadSta, untConsultaCadStaGeral, Data.DB,untIConfTinta, untTintaMaquina,
  untConsultaCadStaVenda,  untFatDigEmbalagem;

function fDigEmbalagem(Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;
Var
  conf: IConfTinta;
begin
  conf := fGetConfTinta('STA');
  Try
    Application.CreateForm(TfrmFatDigEmbalagem, frmFatDigEmbalagem);
    frmFatDigEmbalagem.strTipEmb      := strTipEmb;
    frmFatDigEmbalagem.edtQtdEmb.Text := IntToStr(intQtdEmb);
    frmFatDigEmbalagem.showModal;
  Finally
    Result := frmFatDigEmbalagem.blnConfirma;
    {*****************************************}
    {* CASO TENHA CANCELADO, SAI, SENAO      *}
    {* ATUALIZA AS VARIAVEIS                 *}
    {**************************************MV*}
    If (Result) Then
    Begin
      strTipEmb := frmFatDigEmbalagem.strTipEmb;
      intQtdEmb := StrToInt(frmFatDigEmbalagem.edtQtdEmb.Text);
    End;
    FreeAndNil(frmFatDigEmbalagem);
  End;

  If (Not Result) Then
    Exit;

  {*****************************************}
  {* LITRO                                 *}
  {**************************************MV*}
  If (strTipEmb = 'LT') Then
  Begin
    fltPreEmb := conf.fGetDouble('STAPLT') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPLT', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := conf.fGetDouble('STAPGL') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPGL', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;


function fRetornaDescricaoStarmix(qryCadSta: TUniQuery): String;
begin
  Result := qryCadSta.FieldByName('STA_NOMCOR').AsString + ' ' +
            qryCadSta.FieldByName('STA_CODLIN').AsString + ' ' +
            qryCadSta.FieldByName('STA_CODMON').AsString + ' ' +
            qryCadSta.FieldByName('STA_UNIVER').AsString;
End;

function fConsultaStarmix(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndSta: TStringList;
    stlDesIndSta: TStringList;

    strPreLt: String;
    strPreGl: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);
  conf := fGetConfTinta('STA');

  strPreLt := conf.fGet('STAPLT'); //fArqIniTinta(0, 'STARMIX', 'STAPLT', '0.00');
  strPreGl := conf.fGet('STAPGL'); //fArqIniTinta(0, 'STARMIX', 'STAPGL', '0.00');

  strPreLt := AnsiReplaceStr(strPreLt, ',', '.');
  strPreGl := AnsiReplaceStr(strPreGl, ',', '.');

  stlCamIndSta := TStringList.Create;
  stlDesIndSta := TStringList.Create;

  stlCamIndSta.Add('STA_NOMCOR');
  stlCamIndSta.Add('STA_CODLIN');
  stlCamIndSta.Add('STA_CODMON');
  stlCamIndSta.Add('STA_UNIVER');
  stlCamIndSta.Add('STA_ANOCOR');

  stlDesIndSta.Add('Descricao');
  stlDesIndSta.Add('Linha');
  stlDesIndSta.Add('Montadora');
  stlDesIndSta.Add('Cod. Universal');
  stlDesIndSta.Add('Ano');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  STA_NOMCOR AS "Descricao", ';
  strSQL := strSQL + '  STA_CODLIN AS "Linha", ';
  strSQL := strSQL + '  STA_CODMON AS "Montadora", ';
  strSQL := strSQL + '  STA_UNIVER AS "Cod. Universal", ';
  strSQL := strSQL + '  STA_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  STA_PRECUS + ' + strPreLt + ' AS STA_PRECUS, ';
  strSQL := strSQL + '  (STA_PRECUS * 4) + ' + strPreGl + ' AS STA_PRECUS_GL, ';
  strSQL := strSQL + '  STA_PREVEN + ' + strPreLt + ' AS STA_PREVEN, ';
  strSQL := strSQL + '  (STA_PREVEN * 4) + ' + strPreGl + ' AS STA_PREVEN_GL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  STA_CADSTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM > 0 ';

  Application.CreateForm(TfrmConsultaCadSta, frmConsultaCadSta);

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadSta, qryConsulta01, 'STA_CADSTA',
      strSQL, stlCamIndSta, stlDesIndSta, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadSta);

  FreeAndNil(stlCamIndSta);
  FreeAndNil(stlDesIndSta);
  FreeAndNil(qryConsulta01);

end;

function fConsultaStarmixGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndSta: TStringList;
    stlDesIndSta: TStringList;
    strPreLt: String;
    strPreGl: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);
  conf := fGetConfTinta('STA');

  strPreLt := conf.fGet('STAPLT'); //fArqIniTinta(0, 'STARMIX', 'STAPLT', '0.00');
  strPreGl := conf.fGet('STAPGL'); //fArqIniTinta(0, 'STARMIX', 'STAPGL', '0.00');

  strPreLt := AnsiReplaceStr(strPreLt, ',', '.');
  strPreGl := AnsiReplaceStr(strPreGl, ',', '.');

  stlCamIndSta := TStringList.Create;
  stlDesIndSta := TStringList.Create;

  stlCamIndSta.Add('STA_NOMCOR');
  stlCamIndSta.Add('STA_CODLIN');
  stlCamIndSta.Add('STA_CODMON');
  stlCamIndSta.Add('STA_UNIVER');
  stlCamIndSta.Add('STA_ANOCOR');

  stlDesIndSta.Add('Descricao');
  stlDesIndSta.Add('Linha');
  stlDesIndSta.Add('Montadora');
  stlDesIndSta.Add('Cod. Universal');
  stlDesIndSta.Add('Ano');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  STA_NOMCOR AS "Descricao", ';
  strSQL := strSQL + '  STA_CODLIN AS "Linha", ';
  strSQL := strSQL + '  STA_CODMON AS "Montadora", ';
  strSQL := strSQL + '  STA_UNIVER AS "Cod. Universal", ';
  strSQL := strSQL + '  STA_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  STA_PREVEN + ' + strPreLt + ' AS STA_PREVEN, ';
  strSQL := strSQL + '  (STA_PREVEN * 4) + ' + strPreGl + ' AS STA_PREVEN_GL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  STA_CADSTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM > 0 ';

  Application.CreateForm(TfrmConsultaCadStaGeral, frmConsultaCadStaGeral);

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadStaGeral, qryConsulta01, 'STA_CADSTA',
      strSQL, stlCamIndSta, stlDesIndSta, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadStaGeral);

  FreeAndNil(stlCamIndSta);
  FreeAndNil(stlDesIndSta);
  FreeAndNil(qryConsulta01);

end;

function fConsultaStarmixVenda(Sender: TForm; strCodEmp: String;
  Var qryCadSta: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndSta: TStringList;
    stlDesIndSta: TStringList;
    strPreLt: String;
    strPreGl: String;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('STA');

  strPreLt := conf.fGet('STAPLT'); //fArqIniTinta(0, 'STARMIX', 'STAPLT', '0.00');
  strPreGl := conf.fGet('STAPGL'); //fArqIniTinta(0, 'STARMIX', 'STAPGL', '0.00');

  strPreLt := AnsiReplaceStr(strPreLt, ',', '.');
  strPreGl := AnsiReplaceStr(strPreGl, ',', '.');
  stlCamIndSta := TStringList.Create;
  stlDesIndSta := TStringList.Create;

  stlCamIndSta.Add('STA_NOMCOR');
  stlCamIndSta.Add('STA_CODLIN');
  stlCamIndSta.Add('STA_CODMON');
  stlCamIndSta.Add('STA_UNIVER');
  stlCamIndSta.Add('STA_ANOCOR');

  stlDesIndSta.Add('Descricao');
  stlDesIndSta.Add('Linha');
  stlDesIndSta.Add('Montadora');
  stlDesIndSta.Add('Cod. Universal');
  stlDesIndSta.Add('Ano');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  STA_NOMCOR AS "Descricao", ';
  strSQL := strSQL + '  STA_CODLIN AS "Linha", ';
  strSQL := strSQL + '  STA_CODMON AS "Montadora", ';
  strSQL := strSQL + '  STA_UNIVER AS "Cod. Universal", ';
  strSQL := strSQL + '  STA_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  STA_PREVEN + ' + strPreLt + ' AS STA_PREVEN, ';
  strSQL := strSQL + '  (STA_PREVEN * 4) + ' + strPreGl + ' AS STA_PREVEN_GL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  STA_CADSTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM > 0 ';

  Application.CreateForm(TfrmConsultaCadStaVenda, frmConsultaCadStaVenda);

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadStaVenda, qryCadSta, 'STA_CADSTA',
      strSQL, stlCamIndSta, stlDesIndSta, '', False, True, 5, True) Then
  Begin
    If (Not qryCadSta.IsEmpty) Then
      Result := qryCadSta.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadStaVenda);

  FreeAndNil(stlCamIndSta);
  FreeAndNil(stlDesIndSta);

end;

function fRetornaPrecoStarmix(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    blnUsaPreCus: Boolean;
    strTipEmb: String;
    intQtdEmb: Integer;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;

    strIteSta: String;
    strIteTin: String;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    fltPrcTin: Double;
    fltPrvTin: Double;
    conf: IConfTinta;
begin

  Result := False;
  conf      := fGetConfTinta('STA');
  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTipEmb    := dicRetorno['tipemb'];
  intQtdEmb    := dicRetorno['qtdemb'];

  If (fConsultaStarmixVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('STA_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('STA_CODMON').AsString;
  strA_n_o_ := qryTinta.FieldByName('STA_ANOCOR').AsString;

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  strIteSta := conf.fGet('PROSTA'); //fArqIniTinta(0, 'STARMIX', 'PROSTA', '');

  If (strTipEmb = 'LT') Then
  Begin
    strIteEmb := conf.fGet('STAIEM'); //fArqIniTinta(0, 'STARMIX', 'STAIEM', '');
  End
  Else
  Begin
    strIteEmb := conf.fGet('STAIGL'); //fArqIniTinta(0, 'STARMIX', 'STAIGL', '');
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPrcTin := qryTinta.FieldByName('STA_PRECUS').AsFloat / 0.900;
  fltPreCus := qryTinta.FieldByName('STA_PRECUS').AsFloat / 0.900;

  If (blnUsaPreCus)      And
     (strOpcDoc <> 'BR') Then
  Begin
    fltPrvTin := qryTinta.FieldByName('STA_PRECUS').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('STA_PRECUS').AsFloat / 0.900;
  End
  Else
  Begin
    fltPrvTin := qryTinta.FieldByName('STA_PREVEN').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('STA_PREVEN').AsFloat / 0.900;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := strIteSta;
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := fRetornaDescricaoStarmix(qryTinta) + strTipEmb;
  
  Result := True;

End;

function fRetornaUniTraProStarmix(qryCadSta: TUniQuery; fltPreEmb,
  fltQuanti: Double; strIteTin: String): Double;
  Var
    strTraSta: String;
    fltFatSta: Double;
    strSQL: String;
    conf: IConfTinta;
begin
  conf   := fGetConfTinta('STA');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  STA_CADSTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  STA_CODSEQ = :ITETIN ';

  With qryCadSta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

  End;

  strTraSta := conf.fGet('TRASTA'); //fArqIniTinta(0, 'STARMIX', 'TRASTA', '');
  fltFatSta := conf.fGetDouble('FATSTA'); //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'FATSTA', ''));

  Result := fFormataFloat(qryCadSta.FieldByName('STA_PRE' + strTraSta).AsFloat, 2);
  Result := fFormataFloat(Result / 0.900, 2);
  Result := fFormataFloat(Result * fltFatSta, 2);
End;

function fRetornaUniTraEmbStarmix(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('STA');
  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('STAPLT') //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPLT', ''))
  Else
    fltPreEmb := conf.fGetDouble('STAPGL');//fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPGL', ''));

  Result := fltPreEmb * conf.fGetDouble('FATSTA'); //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'FATSTA', ''))
end;

procedure pRetornaDadosStarmix(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadSta: TUniQuery;
    strSQL: String;
begin
  qryCadSta := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  STA_CADSTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  STA_CODSEQ = :ITETIN ';

  With qryCadSta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('STA_UNIVER').AsString;
    dicRetorno['montad'] := FieldByName('STA_CODMON').AsString;
    dicRetorno['martin'] := FieldByName('STA_CODLIN').AsString;
    Close;
  End;

  FreeAndNil(qryCadSta);
end;

end.
