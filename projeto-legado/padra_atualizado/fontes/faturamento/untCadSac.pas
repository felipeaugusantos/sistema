unit untCadSac;

interface

uses Classes, DB, untFuncoesSimples, Uni;

Type TCadSac = Class(TComponent)

  Private
    FCodSac : String;
    FDtaAtn : TDateTime;
    FCodCli : String;
    FCodVed : String;
    FCodIte : String;
    FQtdIte : Double;
    FDesPro : String;
    FDesSol : String;
    FProRes : String;
    FCodOpe : String;
    FNomCli : String;
    FNomVen : String;
    FDesIte : String;
    FNomRep : String;

    function getDtaAtn: string;
    function getQtdIte: String;

    procedure setDtaAtn(const Value: string);
    procedure setQtdIte(const Value: String);
    procedure pAfterOpen(Dataset: TDataSet);

  Public
    qryTabela : TUniQuery;
    arrDefCam: TArrDefCam;

    Property strCodSac: String Read FCodSac Write FCodSac;
    Property strDtaAtn: String Read getDtaAtn Write setDtaAtn;
    Property strCodCli: String Read FCodCli Write FCodCli;
    Property strCodVed: String Read FCodVed Write FCodVed;
    Property strCodIte: String Read FCodIte Write FCodIte;
    Property strQtdIte: String Read getQtdIte Write setQtdIte;
    Property strDesPro: String Read FDesPro Write FDesPro;
    Property strDesSol: String Read FDesSol Write FDesSol;
    Property strProRes: String Read FProRes Write FProRes;
    Property strCodOpe: String Read FCodOpe Write FCodOpe;
    Property strNomCli: String Read FNomCli Write FNomCli;
    Property strNomVen: String Read FNomVen Write FNomVen;
    Property strDesIte: String Read FDesIte Write FDesIte;
    Property strNomRep: String Read FNomRep Write FNomRep;



    Constructor Create(Owner: TComponent); Reintroduce;

    End;


Const

  arrCampos:    array[0..15] of String = ('AUTOINCREM ','SAC_CODEMP ','SAC_CODSAC ',
                                          'SAC_DTAATN ','SAC_CODCLI ','SAC_CODVEN ',
                                          'SAC_CODITE ','SAC_QTDITE ','SAC_DESPRB ',
                                          'SAC_DESSOL ','SAC_RSLPRO ','SAC_CODREP ',
                                          'SAC_NOMCLI ','SAC_NOMVEN ','SAC_DESITE ',
                                          'SAC_NOMREP ');

  arrDescricao: array[0..15] of String = ('AUTOINCREM','Código Empresa','Código',
                                          'Data Atendimento','Código Cliente','Código Vendedor',
                                          'Código do Produto','Quantidade do Produto','Descrição do Problema',
                                          'Descrição da Solução','Problema Resolvido','Código do Responsável',
                                          'Nome do Cliente','Nome do Vendedor','Descrição do Produto',
                                          'Nome do Responsável');

  arrTipo:  array[0..15] of TFieldType = (ftString,ftString,ftString,ftDate,ftString,ftString,ftString,ftFloat,ftString,ftString,ftString,ftString,ftString,ftString,ftString,ftString);

  arrTamanhos: array[0..15] of Integer = (20,3,6,0,8,3,5,10,0,0,1,3,60,30,70,30);

  arrVisible:  array[0..15] of Boolean = (False,True,True,True,True,True,True,True,True,True,True,True,True,True,True,True);

  arrFormat:   array[0..15] of String  = ('','','','99/99/9999;1;_','','','','#,##0,00','','','','','','','','');

implementation
{CADSAC}

uses SysUtils;

constructor TCadSac.Create(Owner: TComponent);
  Var
    IntContador: Integer;
begin
  inherited Create(Owner);

  Try
    SetLength(arrDefCam,12);

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam := arrCampos[intContador];
      arrDefCam[intContador].strDesCri := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam := arrTipo[intContador];

      {********************************************}
      { PARA USAR A CONFIGURAÇÃO DO BANCO DE DADOS }
      { CASO SEJA CODITE                           }
      {*****************************************CH*}
      arrDefCam[intContador].intTamCam := IIF( arrCampos[intContador] = 'SAC_CODITE ',
                                               fTamCodIte,
                                               arrTamanhos[intContador]);

      arrDefCam[intContador].blnVisible:= arrVisible[intContador];
      arrDefCam[intContador].strFormat := arrFormat[intContador];
    End;

    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADSAC WHERE FALSE');
    qryTabela.Open;

    FCodSac := '';
    FDtaAtn := 0;
    FCodCli := '';
    FCodVed := '';
    FCodIte := '';
    FQtdIte := 0.00;
    FDesPro := '';
    FDesSol := '';
    FProRes := '';
    FCodOpe := '';
    FNomCli := '';
    FNomVen := '';
    FDesIte := '';
    FNomRep := '';


  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadSac!' + #13 + E.Message);

  End;

end;

function TCadSac.getDtaAtn: string;
begin
  Result := FormatDateTime('dd/mm/yyyy',FDtaAtn);
end;

procedure TCadSac.setDtaAtn(const Value: string);
begin

  If Not fEmptyStr(fTiraCaracEspeciais(Value)) Then
    FDtaAtn := StrToDateTime(Value)
  Else
    Raise Exception.Create('A Data do Atendimento deve ser preenchida!');

end;

procedure TCadSac.pAfterOpen(Dataset: TDataSet);
begin
  TDateField(qryTabela.FieldByName('SAC_DTAATN')).EditMask      := '99/99/9999;1;_';
  TDateField(qryTabela.FieldByName('SAC_DTASOL')).EditMask      := '99/99/9999;1;_';
  TFloatField(qryTabela.FieldByname('SAC_QTDITE')).EditFormat   := '#,##0.00';
  TFloatField(qryTabela.FieldByname('SAC_QTDITE')).DisplayFormat:= '#,##0.00';
  TDateField(qryTabela.FieldByName('SAC_RESOLV')).EditMask      := '99/99/9999;1;_';
end;

function TCadSac.getQtdIte: String;
begin
  Result := FloatToStrF(FQtdIte,ffNumber,10,2);
end;

procedure TCadSac.setQtdIte(const Value: String);
begin
  FQtdIte := StrToInt(Value);
end;


end.
