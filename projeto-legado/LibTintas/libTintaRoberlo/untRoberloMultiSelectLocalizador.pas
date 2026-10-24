unit untRoberloMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TRoberloMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;


implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TRoberloMultiSelectLocalizador }

constructor TRoberloMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ROB_MD5KEY FROM ROB_CADROB WHERE FALSE', 'ROB_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ROB_CADROB            ' +
      ' WHERE ROB_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;


initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ROB', TRoberloMultiSelectLocalizador);

end.
