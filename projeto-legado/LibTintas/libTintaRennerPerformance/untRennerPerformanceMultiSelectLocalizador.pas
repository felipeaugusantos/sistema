unit untRennerPerformanceMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TRennerPerformanceMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;


implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TRennerPerformanceMultiSelectLocalizador }

constructor TRennerPerformanceMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT REP_MD5KEY FROM REP_CADREP WHERE FALSE', 'REP_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   REP_CADREP            ' +
      ' WHERE REP_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;


initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('REP', TRennerPerformanceMultiSelectLocalizador);

end.
