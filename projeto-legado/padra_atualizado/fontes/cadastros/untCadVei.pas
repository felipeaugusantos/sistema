{*******************************************}
{* CLASSE PARA O CADASTRO DE VEICULOS      *}
{* DATA......: 24/03/2010                  *}
{****************************************IV*}
unit untCadVei;

interface

uses Classes, untFuncoesSimples, Uni, DB;

Type TCadVei = Class (TComponent)
  Private
    FZeroKm: String;
    FPlaVei: String;
//    FDesVei: String;
    FChassi: String;
    FCodMod: String;
    FCodMar: String;
    FCodCor: String;
    FAnoVei: String;
    FCondut: String;
    FObserv: String;
    FAutInc: String;
    FCapCar: Integer;
    FPinQlp: String;
    FTipVei: String;
    FQtdEix: Integer;
    FTipCmb: String;
    FAutKml: Double;
    FTipAfr: String;
    FAcrFre: Double;

    FScroll: TDataSetNotifyEvent;

    procedure pAfterOpen(Dataset: TDataSet);
    procedure pAfterScroll(Dataset: TDataSet);

  Public

    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strZerokm: String  Read FZeroKm Write FZeroKm;
    Property strPlaVei: String  Read FPlaVei Write FPlaVei;
//    Property strDesVei: String  Read FDesVei Write FDesVei;
    Property strChassi: String  Read FChassi Write FChassi;
    Property strCodMod: String  Read FCodMod Write FCodMod;
    Property strCodMar: String  Read FCodMar Write FCodMar;
    Property strCodCor: String  Read FCodCor Write FCodCor;
    Property strAnoVei: String  Read FAnoVei Write FAnoVei;
    Property strCondut: String  Read FCondut Write FCondut;
    Property strObserv: String  Read FObserv Write FObserv;
    Property strAutInc: String  Read FAutInc Write FAutInc;
    Property intCapCar: Integer Read FCapCar Write FCapCar;
    property strPinQlp: String  read FPinQlp write FPinQlp;
    property strTipVei: String  read FTipVei write FTipVei;
    property intQtdEix: Integer read FQtdEix write FQtdEix;
    property strTipCmb: String  read FTipCmb write FTipCmb;
    property dblAutKml: Double  read FAutKml write FAutKml;
    property strTipAfr: String  read FTipAfr write FTipAfr;
    property dblAcrFre: Double  read FAcrFre write FAcrFre;
    Property pOnScroll: TDataSetNotifyEvent Read FScroll Write FScroll;

    Constructor Create(Owner: TComponent); Reintroduce;

  end;

Const
  arrCampos   : Array[0..17] Of String = ( 'VEI_ZEROKM', 'VEI_PLAVEI',{'VEI_DESVEI',}'VEI_CHASSI','VEI_CODMOD','VEI_CODMAR',
                                           'VEI_CODCOR','VEI_ANOVEI','VEI_CONDUT','AUTOINCREM', 'VEI_OBSERV', 'VEI_CAPCAR',
                                           'VEI_PINQLP','VEI_TIPVEI','VEI_QTDEIX','VEI_TIPCMB','VEI_AUTKML','VEI_TIPAFR',
                                           'VEI_ACRFRE');

  arrDescricao: Array[0..17] Of String = ( 'Zero Km', 'Placa',{'Descrição',}'Chassi','Modelo','Marca','Cor','Ano',
                                           'Condutor','AUTOINCREM','Observações', 'Cap. Carga', 'Participa Integração QUALP',
                                           'Tipo Veículo','Qtd. Eixos','Tipo Combustível','Autonomia Km/L',
                                           'Tipo Acrésc. Frete','Acréscimo Frete');

  arrTipo     : Array[0..17] Of TFieldType = ( ftString, ftString, {ftString,} ftString, ftString, ftString, ftString,
                                               ftString, ftString, ftString, ftString, ftInteger, ftString, ftString,
                                               ftInteger, ftString, ftFloat, ftString, ftFloat );

  arrTamanhos : Array[0..17] Of Integer    = ( 1, 7, {30,} 30, 4, 4, 4, 5, 15, 20, 0, 0, 1, 20, 0, 20, 0, 20, 0 );

  arrVisible  : Array[0..17] Of Boolean    = ( True, True, {True,} True, True, True, True, True, True, False, True, True,
                                               False, False, False, False, False, False, False);

  arrFormat   : Array[0..17] Of String     = ( '', '', {'',} '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                                               '', '' );

implementation


{ TCadVei }

uses SysUtils;

constructor TCadVei.Create(Owner: TComponent);
  Var
    IntContador: Integer;
begin
  inherited;

  Try
    SetLength(arrDefCam, 17);

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam  := arrCampos[intContador];
      arrDefCam[intContador].strDesCri  := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam  := arrTipo[intContador];
      arrDefCam[intContador].intTamCam  := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible := arrVisible[intContador];
      arrDefCam[intContador].strFormat  := arrFormat[intContador];
    End;

    qryTabela             := fCriaQuery(Self);
    qryTabela.AfterOpen   := pAfterOpen;
    qryTabela.AfterScroll := pAfterScroll;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADVEI WHERE FALSE');
    qryTabela.Open;

    FZeroKm := '';
    FPlaVei := '';
//    FDesVei := '';
    FChassi := '';
    FCodMod := '';
    FCodMar := '';
    FCodCor := '';
    FAnoVei := '';
    FCondut := '';
    FObserv := '';
    FCapCar := 0;
    FAutInc := '';
    FPinQlp := 'N';
    FTipVei := '';
    FQtdEix := 0;
    FTipCmb := '';
    FAutKml := 0;
    FTipAfr := '';
    FAcrFre := 0;

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadVei!' + #13 + E.Message);

  End;

End;

procedure TCadVei.pAfterOpen(Dataset: TDataSet);
begin
  TStringField(qryTabela.FieldByName('VEI_PLAVEI')).EditMask := 'aaa-9a99;0;_';
end;

procedure TCadVei.pAfterScroll(Dataset: TDataSet);
begin
  If Assigned(FScroll) Then
    FScroll(DataSet);
end;

end.
