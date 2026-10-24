unit untEmpTri;

interface

uses
  Uni, System.Classes, untFuncoesSimples, System.SysUtils, Data.DB;

type
  TEmpTri = class(TComponent)
  private
    FstrLrPisL: String;
    FstrLrCofL: String;
    FstrLrIcmL: String;
    FstrLrIpiL: String;
    FstrLrRetL: String;
    FstrLrFreL: String;
    FstrLrJurR: String;
    FstrLrJurP: String;
    FstrLrDesR: String;
    FstrLrDesO: String;
    FflrLpAlqI: Double;
    FfltLpAlqC: Double;
    FstrLpPisL: String;
    FstrLpCofL: String;
    FstrLpIcmL: String;
    FstrLpIpiL: String;
    FstrLpRetL: String;
    FstrLpFreL: String;
    FstrLpJurR: String;
    FstrLpJurP: String;
    FstrLpDesR: String;
    FstrLpDesO: String;
    FfltSnAlqF: Double;
    FstrSnIcmL: String;
    FstrSnIpiL: String;
    FstrSnRetL: String;
    FstrSnFreL: String;
    FstrSnJurR: String;
    FstrSnJurP: String;
    FstrSnDesR: String;
    FstrSnDesO: String;
    FstrLrCFFD: String;
    FstrLpCFFD: String;
    FstrSnCFFD: String;
    FstrSnRCAT: String;

    procedure pPreencheCampos;
    procedure pAfterOpen(DataSet: TDataSet);
  public
    qryTabela: TUniQuery;

    constructor Create(Owner: TComponent); Override;

    procedure pCarregaEmpTri(strCodEmp: String);
    procedure pIniciaInsercao;
    function fGravaDados: Boolean;

    procedure pReplicaRegimeTributario(strCodEmp: String; strRegTri: String);

    property strLrPisL: String Read FstrLrPisL Write FstrLrPisL;
    property strLrCofL: String Read FstrLrCofL Write FstrLrCofL;
    property strLrIcmL: String Read FstrLrIcmL Write FstrLrIcmL;
    property strLrIpiL: String Read FstrLrIpiL Write FstrLrIpiL;
    property strLrRetL: String Read FstrLrRetL Write FstrLrRetL;
    property strLrFreL: String Read FstrLrFreL Write FstrLrFreL;
    property strLrJurR: String Read FstrLrJurR Write FstrLrJurR;
    property strLrJurP: String Read FstrLrJurP Write FstrLrJurP;
    property strLrDesR: String Read FstrLrDesR Write FstrLrDesR;
    property strLrDesO: String Read FstrLrDesO Write FstrLrDesO;
    property flrLpAlqI: Double Read FflrLpAlqI Write FflrLpAlqI;
    property fltLpAlqC: Double Read FfltLpAlqC Write FfltLpAlqC;
    property strLpPisL: String Read FstrLpPisL Write FstrLpPisL;
    property strLpCofL: String Read FstrLpCofL Write FstrLpCofL;
    property strLpIcmL: String Read FstrLpIcmL Write FstrLpIcmL;
    property strLpIpiL: String Read FstrLpIpiL Write FstrLpIpiL;
    property strLpRetL: String Read FstrLpRetL Write FstrLpRetL;
    property strLpFreL: String Read FstrLpFreL Write FstrLpFreL;
    property strLpJurR: String Read FstrLpJurR Write FstrLpJurR;
    property strLpJurP: String Read FstrLpJurP Write FstrLpJurP;
    property strLpDesR: String Read FstrLpDesR Write FstrLpDesR;
    property strLpDesO: String Read FstrLpDesO Write FstrLpDesO;
    property fltSnAlqF: Double Read FfltSnAlqF Write FfltSnAlqF;
    property strSnIcmL: String Read FstrSnIcmL Write FstrSnIcmL;
    property strSnIpiL: String Read FstrSnIpiL Write FstrSnIpiL;
    property strSnRetL: String Read FstrSnRetL Write FstrSnRetL;
    property strSnFreL: String Read FstrSnFreL Write FstrSnFreL;
    property strSnJurR: String Read FstrSnJurR Write FstrSnJurR;
    property strSnJurP: String Read FstrSnJurP Write FstrSnJurP;
    property strSnDesR: String Read FstrSnDesR Write FstrSnDesR;
    property strSnDesO: String Read FstrSnDesO Write FstrSnDesO;
    property strLrCFFD: String Read FstrLrCFFD Write FstrLrCFFD;
    property strLpCFFD: String Read FstrLpCFFD Write FstrLpCFFD;
    property strSnCFFD: String Read FstrSnCFFD Write FstrSnCFFD;
    property strSnRCAT: String Read FstrSnRCAT Write FstrSnRCAT;

  End;

implementation

{ TEmpTri }

constructor TEmpTri.Create(Owner: TComponent);
begin
  inherited;

  Try
    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM EMPTRI WHERE FALSE');
    qryTabela.Open;

    FstrLrPisL := '';
    FstrLrCofL := '';
    FstrLrIcmL := '';
    FstrLrIpiL := '';
    FstrLrRetL := '';
    FstrLrFreL := '';
    FstrLrJurR := '';
    FstrLrJurP := '';
    FstrLrDesR := '';
    FstrLrDesO := '';
    FflrLpAlqI := 0;
    FfltLpAlqC := 0;
    FstrLpPisL := '';
    FstrLpCofL := '';
    FstrLpIcmL := '';
    FstrLpIpiL := '';
    FstrLpRetL := '';
    FstrLpFreL := '';
    FstrLpJurR := '';
    FstrLpJurP := '';
    FstrLpDesR := '';
    FstrLpDesO := '';
    FfltSnAlqF := 0;
    FstrSnIcmL := '';
    FstrSnIpiL := '';
    FstrSnRetL := '';
    FstrSnFreL := '';
    FstrSnJurR := '';
    FstrSnJurP := '';
    FstrSnDesR := '';
    FstrSnDesO := '';
    FstrLrCFFD := '';
    FstrLpCFFD := '';
    FstrSnCFFD := '';
    FstrSnRCAT := '';
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto TEmpTri!' + #13 + E.Message);
  End;
end;

procedure TEmpTri.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('TRI_LPALQI') <> nil Then
      TFloatField(FieldByName('TRI_LPALQI')).DisplayFormat := '#,##0.00';

    If FindField('TRI_LPALQC') <> nil Then
      TFloatField(FieldByName('TRI_LPALQC')).DisplayFormat := '#,##0.00';

    If FindField('TRI_SNALQF') <> nil Then
      TFloatField(FieldByName('TRI_SNALQF')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TEmpTri.pCarregaEmpTri(strCodEmp: String);
begin
  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM EMPTRI WHERE TRI_CODEMP = :CODEMP');
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    pPreencheCampos;
  End;
end;

function TEmpTri.fGravaDados: Boolean;
begin
  Result := True;

  Try
    If Not (qryTabela.State In [dsEdit, dsInsert]) Then
      Exit;

    If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EMPTRI', VS_strCodEmp);

    qryTabela.Post;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEmpTri.fGravaDados]');
    End;
  End;
end;

procedure TEmpTri.pIniciaInsercao;
begin
  With qryTabela Do
  Begin
    If State = dsBrowse Then
      Append;

    FieldByName('TRI_LRPISL').AsString := 'N';
    FieldByName('TRI_LRCOFL').AsString := 'N';
    FieldByName('TRI_LRICML').AsString := 'N';
    FieldByName('TRI_LRIPIL').AsString := 'N';
    FieldByName('TRI_LRRETL').AsString := 'N';
    FieldByName('TRI_LRFREL').AsString := 'N';
    FieldByName('TRI_LRJURR').AsString := 'V';
    FieldByName('TRI_LRJURP').AsString := 'N';
    FieldByName('TRI_LRDESR').AsString := 'V';
    FieldByName('TRI_LRDESO').AsString := 'N';
    FieldByName('TRI_LPALQI').AsFloat  := 0;
    FieldByName('TRI_LPALQC').AsFloat  := 0;
    FieldByName('TRI_LPPISL').AsString := 'N';
    FieldByName('TRI_LPCOFL').AsString := 'N';
    FieldByName('TRI_LPICML').AsString := 'N';
    FieldByName('TRI_LPIPIL').AsString := 'N';
    FieldByName('TRI_LPRETL').AsString := 'N';
    FieldByName('TRI_LPFREL').AsString := 'N';
    FieldByName('TRI_LPJURR').AsString := 'V';
    FieldByName('TRI_LPJURP').AsString := 'N';
    FieldByName('TRI_LPDESR').AsString := 'V';
    FieldByName('TRI_LPDESO').AsString := 'N';
    FieldByName('TRI_SNALQF').AsFloat  := 0;
    FieldByName('TRI_SNICML').AsString := 'N';
    FieldByName('TRI_SNIPIL').AsString := 'N';
    FieldByName('TRI_SNRETL').AsString := 'N';
    FieldByName('TRI_SNFREL').AsString := 'N';
    FieldByName('TRI_SNJURR').AsString := 'V';
    FieldByName('TRI_SNJURP').AsString := 'N';
    FieldByName('TRI_SNDESR').AsString := 'V';
    FieldByName('TRI_SNDESO').AsString := 'N';
    FieldByName('TRI_LRCFFD').AsString := 'S';
    FieldByName('TRI_LPCFFD').AsString := 'S';
    FieldByName('TRI_SNCFFD').AsString := 'S';
    FieldByName('TRI_SNRCAT').AsString := 'N';
  End;
end;

procedure TEmpTri.pPreencheCampos;
begin
  With qryTabela Do
  Begin
    FstrLrPisL := FieldByName('TRI_LRPISL').AsString;
    FstrLrCofL := FieldByName('TRI_LRCOFL').AsString;
    FstrLrIcmL := FieldByName('TRI_LRICML').AsString;
    FstrLrIpiL := FieldByName('TRI_LRIPIL').AsString;
    FstrLrRetL := FieldByName('TRI_LRRETL').AsString;
    FstrLrFreL := FieldByName('TRI_LRFREL').AsString;
    FstrLrJurR := FieldByName('TRI_LRJURR').AsString;
    FstrLrJurP := FieldByName('TRI_LRJURP').AsString;
    FstrLrDesR := FieldByName('TRI_LRDESR').AsString;
    FstrLrDesO := FieldByName('TRI_LRDESO').AsString;
    FflrLpAlqI := FieldByName('TRI_LPALQI').AsFloat;
    FfltLpAlqC := FieldByName('TRI_LPALQC').AsFloat;
    FstrLpPisL := FieldByName('TRI_LPPISL').AsString;
    FstrLpCofL := FieldByName('TRI_LPCOFL').AsString;
    FstrLpIcmL := FieldByName('TRI_LPICML').AsString;
    FstrLpIpiL := FieldByName('TRI_LPIPIL').AsString;
    FstrLpRetL := FieldByName('TRI_LPRETL').AsString;
    FstrLpFreL := FieldByName('TRI_LPFREL').AsString;
    FstrLpJurR := FieldByName('TRI_LPJURR').AsString;
    FstrLpJurP := FieldByName('TRI_LPJURP').AsString;
    FstrLpDesR := FieldByName('TRI_LPDESR').AsString;
    FstrLpDesO := FieldByName('TRI_LPDESO').AsString;
    FfltSnAlqF := FieldByName('TRI_SNALQF').AsFloat;
    FstrSnIcmL := FieldByName('TRI_SNICML').AsString;
    FstrSnIpiL := FieldByName('TRI_SNIPIL').AsString;
    FstrSnRetL := FieldByName('TRI_SNRETL').AsString;
    FstrSnFreL := FieldByName('TRI_SNFREL').AsString;
    FstrSnJurR := FieldByName('TRI_SNJURR').AsString;
    FstrSnJurP := FieldByName('TRI_SNJURP').AsString;
    FstrSnDesR := FieldByName('TRI_SNDESR').AsString;
    FstrSnDesO := FieldByName('TRI_SNDESO').AsString;
    FstrLrCFFD := FieldByName('TRI_LRCFFD').AsString;
    FstrLpCFFD := FieldByName('TRI_LPCFFD').AsString;
    FstrSnCFFD := FieldByName('TRI_SNCFFD').AsString;
    FstrSnRCAT := FieldByName('TRI_SNRCAT').AsString;
  End;
end;

procedure TEmpTri.pReplicaRegimeTributario(strCodEmp: String;
  strRegTri: String);
  Var
    strUpd: String;
    qryUpd: TUniQuery;
begin
  If qryTabela.IsEmpty Then
    Exit;

  strUpd := '';
  strUpd := strUpd + ' UPDATE ';
  strUpd := strUpd + '   EMPTRI ';
  strUpd := strUpd + ' SET ';
  strUpd := strUpd + '   TRI_LRPISL = :LRPISL , ';
  strUpd := strUpd + '   TRI_LRCOFL = :LRCOFL , ';
  strUpd := strUpd + '   TRI_LRICML = :LRICML , ';
  strUpd := strUpd + '   TRI_LRIPIL = :LRIPIL , ';
  strUpd := strUpd + '   TRI_LRRETL = :LRRETL , ';
  strUpd := strUpd + '   TRI_LRFREL = :LRFREL , ';
  strUpd := strUpd + '   TRI_LRJURR = :LRJURR , ';
  strUpd := strUpd + '   TRI_LRJURP = :LRJURP , ';
  strUpd := strUpd + '   TRI_LRDESR = :LRDESR , ';
  strUpd := strUpd + '   TRI_LRDESO = :LRDESO , ';
  strUpd := strUpd + '   TRI_LPALQI = :LPALQI , ';
  strUpd := strUpd + '   TRI_LPALQC = :LPALQC , ';
  strUpd := strUpd + '   TRI_LPPISL = :LPPISL , ';
  strUpd := strUpd + '   TRI_LPCOFL = :LPCOFL , ';
  strUpd := strUpd + '   TRI_LPICML = :LPICML , ';
  strUpd := strUpd + '   TRI_LPIPIL = :LPIPIL , ';
  strUpd := strUpd + '   TRI_LPRETL = :LPRETL , ';
  strUpd := strUpd + '   TRI_LPFREL = :LPFREL , ';
  strUpd := strUpd + '   TRI_LPJURR = :LPJURR , ';
  strUpd := strUpd + '   TRI_LPJURP = :LPJURP , ';
  strUpd := strUpd + '   TRI_LPDESR = :LPDESR , ';
  strUpd := strUpd + '   TRI_LPDESO = :LPDESO , ';
  strUpd := strUpd + '   TRI_SNALQF = :SNALQF , ';
  strUpd := strUpd + '   TRI_SNICML = :SNICML , ';
  strUpd := strUpd + '   TRI_SNIPIL = :SNIPIL , ';
  strUpd := strUpd + '   TRI_SNRETL = :SNRETL , ';
  strUpd := strUpd + '   TRI_SNFREL = :SNFREL , ';
  strUpd := strUpd + '   TRI_SNJURR = :SNJURR , ';
  strUpd := strUpd + '   TRI_SNJURP = :SNJURP , ';
  strUpd := strUpd + '   TRI_SNDESR = :SNDESR , ';
  strUpd := strUpd + '   TRI_SNDESO = :SNDESO , ';
  strUpd := strUpd + '   TRI_LRCFFD = :LRCFFD , ';
  strUpd := strUpd + '   TRI_LPCFFD = :LPCFFD , ';
  strUpd := strUpd + '   TRI_SNCFFD = :SNCFFD,  ';
  strUpd := strUpd + '   TRI_SNRCAT = :SNRCAT   ';
  strUpd := strUpd + ' WHERE ';
  strUpd := strUpd + '   TRI_CODEMP = :CODEMP';

  Try
    qryUpd := fCriaQuery;

    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strUpd);

      ParamByName('LRPISL').AsString := qryTabela.FieldByName('TRI_LRPISL').AsString;
      ParamByName('LRCOFL').AsString := qryTabela.FieldByName('TRI_LRCOFL').AsString;
      ParamByName('LRICML').AsString := qryTabela.FieldByName('TRI_LRICML').AsString;
      ParamByName('LRIPIL').AsString := qryTabela.FieldByName('TRI_LRIPIL').AsString;
      ParamByName('LRRETL').AsString := qryTabela.FieldByName('TRI_LRRETL').AsString;
      ParamByName('LRFREL').AsString := qryTabela.FieldByName('TRI_LRFREL').AsString;
      ParamByName('LRJURR').AsString := qryTabela.FieldByName('TRI_LRJURR').AsString;
      ParamByName('LRJURP').AsString := qryTabela.FieldByName('TRI_LRJURP').AsString;
      ParamByName('LRDESR').AsString := qryTabela.FieldByName('TRI_LRDESR').AsString;
      ParamByName('LRDESO').AsString := qryTabela.FieldByName('TRI_LRDESO').AsString;
      ParamByName('LPALQI').AsFloat  := qryTabela.FieldByName('TRI_LPALQI').AsFloat;
      ParamByName('LPALQC').AsFloat  := qryTabela.FieldByName('TRI_LPALQC').AsFloat;
      ParamByName('LPPISL').AsString := qryTabela.FieldByName('TRI_LPPISL').AsString;
      ParamByName('LPCOFL').AsString := qryTabela.FieldByName('TRI_LPCOFL').AsString;
      ParamByName('LPICML').AsString := qryTabela.FieldByName('TRI_LPICML').AsString;
      ParamByName('LPIPIL').AsString := qryTabela.FieldByName('TRI_LPIPIL').AsString;
      ParamByName('LPRETL').AsString := qryTabela.FieldByName('TRI_LPRETL').AsString;
      ParamByName('LPFREL').AsString := qryTabela.FieldByName('TRI_LPFREL').AsString;
      ParamByName('LPJURR').AsString := qryTabela.FieldByName('TRI_LPJURR').AsString;
      ParamByName('LPJURP').AsString := qryTabela.FieldByName('TRI_LPJURP').AsString;
      ParamByName('LPDESR').AsString := qryTabela.FieldByName('TRI_LPDESR').AsString;
      ParamByName('LPDESO').AsString := qryTabela.FieldByName('TRI_LPDESO').AsString;
      ParamByName('SNALQF').AsFloat  := qryTabela.FieldByName('TRI_SNALQF').AsFloat;
      ParamByName('SNICML').AsString := qryTabela.FieldByName('TRI_SNICML').AsString;
      ParamByName('SNIPIL').AsString := qryTabela.FieldByName('TRI_SNIPIL').AsString;
      ParamByName('SNRETL').AsString := qryTabela.FieldByName('TRI_SNRETL').AsString;
      ParamByName('SNFREL').AsString := qryTabela.FieldByName('TRI_SNFREL').AsString;
      ParamByName('SNJURR').AsString := qryTabela.FieldByName('TRI_SNJURR').AsString;
      ParamByName('SNJURP').AsString := qryTabela.FieldByName('TRI_SNJURP').AsString;
      ParamByName('SNDESR').AsString := qryTabela.FieldByName('TRI_SNDESR').AsString;
      ParamByName('SNDESO').AsString := qryTabela.FieldByName('TRI_SNDESO').AsString;
      ParamByName('LRCFFD').AsString := qryTabela.FieldByName('TRI_LRCFFD').AsString;
      ParamByName('LPCFFD').AsString := qryTabela.FieldByName('TRI_LPCFFD').AsString;
      ParamByName('SNCFFD').AsString := qryTabela.FieldByName('TRI_SNCFFD').AsString;
      ParamByName('SNRCAT').AsString := qryTabela.FieldByName('TRI_SNRCAT').AsString;

      ParamByName('CODEMP').AsString := strCodEmp;

      ExecSQL;

      strUpd := '';
      strUpd := strUpd + ' UPDATE ';
      strUpd := strUpd + '   CADEMP ';
      strUpd := strUpd + ' SET ';
      strUpd := strUpd + '   EMP_REGTRI = :REGTRI ';
      strUpd := strUpd + ' WHERE ';
      strUpd := strUpd + '   EMP_CODEMP = :CODEMP ';

      Params.Clear;
      SQL.Clear;
      SQL.Add(strUpd);
      ParamByName('REGTRI').AsString := strRegTri;
      ParamByName('CODEMP').AsString := strCodEmp;

      ExecSQL;
    End;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryUpd);
      pMensagensErro(E.Message, '[TEmpTri.pReplicaRegimeTributario]');
    End;
  End;

  FreeAndNil(qryUpd);
end;

end.
